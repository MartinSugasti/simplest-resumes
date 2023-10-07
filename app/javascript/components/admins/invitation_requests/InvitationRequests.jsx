import React, { useState, useEffect } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import { useTranslation } from 'react-i18next';

import {
  getInvitationRequests,
  approveInvitationRequest,
  dismissInvitationRequest,
  banInvitationRequest
} from './api';

const InvitationRequests = () => {
  const [invitationRequests, setInvitationRequests] = useState([]);
  const [emailToRequest, setEmailToRequest] = useState('');
  const [roleToRequest, setRoleToRequest] = useState('super_admin');
  const { t } = useTranslation();

  useEffect(() => {
    getInvitationRequests().then((response) => {
      setInvitationRequests(response.data);
    }).catch((error) => console.log(error));
  }, []);

  const toastConfig = {
    position: 'bottom-left',
    autoClose: 5000,
    hideProgressBar: false,
    closeOnClick: true,
    pauseOnHover: false,
    draggable: true,
    progress: undefined,
    theme: 'light'
  };

  const showSucessToast = (message) => toast.success(message, toastConfig);
  const showErrorToast = (message) => toast.error(message, toastConfig);

  const showInvitationApprovalModal = (email, role) => {
    setEmailToRequest(email);

    setRoleToRequest(() => {
      if (role === 'Collaborator') {
        return 'collaborator';
      }

      return 'super_admin';
    });
  };

  const handleRoleSelection = (event) => {
    setRoleToRequest(event.target.value);
  };

  const handleInvitationRequestApproval = (email, role) => {
    approveInvitationRequest(email, role)
      .then(() => showSucessToast(t('admins.invitation_requests.index.approval_success')))
      .catch(() => showErrorToast(t('admins.invitation_requests.index.approval_failure')))
      .finally(() => {
        getInvitationRequests().then((response) => setInvitationRequests(response.data));
      });
  };

  const handleInvitationRequestDismiss = (id) => {
    dismissInvitationRequest(id)
      .then((response) => showSucessToast(response.data))
      .catch((error) => showErrorToast(error.response.data))
      .finally(() => {
        getInvitationRequests().then((response) => setInvitationRequests(response.data));
      });
  };

  const handleInvitationRequestBan = (id) => {
    banInvitationRequest(id)
      .then((response) => showSucessToast(response.data))
      .catch((error) => showErrorToast(error.response.data))
      .finally(() => {
        getInvitationRequests().then((response) => setInvitationRequests(response.data));
      });
  };

  return (
    <>
      <div className="table-responsive">
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>Id</th>
              <th>{t('activerecord.attributes.invitation_request.email')}</th>
              <th>{t('activerecord.attributes.invitation_request.status')}</th>
              <th>{t('activerecord.attributes.admin.role')}</th>
              <th>{t('activerecord.attributes.invitation_request.created_at')}</th>
              <th>{t('general.actions')}</th>
            </tr>
          </thead>

          <tbody className="align-middle">
            {invitationRequests.map((invitationRequest, index) => (
              // eslint-disable-next-line react/no-array-index-key
              <tr key={index}>
                <td>{invitationRequest.id}</td>
                <td>{invitationRequest.email}</td>
                <td>{invitationRequest.status}</td>
                <td>{invitationRequest.invited_as}</td>
                <td>{invitationRequest.created_at}</td>
                <td>
                  {invitationRequest.status === 'Pending' && (
                    <>
                      <div className="row mx-0 justify-content-center">
                        <button
                          className="col-12 btn btn-ou btn-outline-primary-dark btn-sm rounded-pill"
                          type="button"
                          data-bs-toggle="modal"
                          data-bs-target="#approve-invitation-request-modal"
                          onClick={
                            () => showInvitationApprovalModal(invitationRequest.email, invitationRequest.invited_as)
                          }
                        >
                          {t('admins.invitation_requests.index.approve')}
                        </button>
                      </div>

                      <div className="row mx-0 justify-content-center">
                        <button
                          className="col-12 mt-1 btn btn-ou btn-outline-danger btn-sm rounded-pill"
                          type="button"
                          onClick={() => handleInvitationRequestDismiss(invitationRequest.id)}
                        >
                          {t('admins.invitation_requests.index.dismiss')}
                        </button>
                      </div>

                      <div className="row mx-0 justify-content-center">
                        <button
                          className="col-12 mt-1 btn btn-ou btn-outline-danger btn-sm rounded-pill"
                          type="button"
                          onClick={() => handleInvitationRequestBan(invitationRequest.id)}
                        >
                          {t('admins.invitation_requests.index.ban')}
                        </button>
                      </div>
                    </>
                  )}

                  {invitationRequest.status === 'Approved' && (
                    <div className="row mx-0 justify-content-center">
                      <button
                        className="col-12 btn btn-ou btn-outline-primary-dark btn-sm rounded-pill"
                        type="button"
                        data-bs-toggle="modal"
                        data-bs-target="#approve-invitation-request-modal"
                        onClick={
                          () => showInvitationApprovalModal(invitationRequest.email, invitationRequest.invited_as)
                        }
                      >
                        {invitationRequest.invited_as === 'Admin Not Found' ? 'Send' : 'Resend'}
                      </button>
                    </div>
                  )}

                  {['Dismissed', 'Banned'].includes(invitationRequest.status) && (
                    <div className="row mx-0 justify-content-center">
                      <button
                        className="col-12 btn btn-ou btn-outline-primary-dark btn-sm rounded-pill"
                        type="button"
                        data-bs-toggle="modal"
                        data-bs-target="#approve-invitation-request-modal"
                        onClick={
                          () => showInvitationApprovalModal(invitationRequest.email, invitationRequest.invited_as)
                        }
                      >
                        {t('admins.invitation_requests.index.approve')}
                      </button>
                    </div>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div
        className="modal fade"
        id="approve-invitation-request-modal"
        tabIndex="-1"
        aria-labelledby="modal-title"
        aria-hidden="true"
      >
        <div className="modal-dialog modal-dialog-centered modal-lg">
          <div className="modal-content bg-light text-dark p-1 p-sm-2 p-lg-3">
            <div className="modal-header border-0">
              <h4 className="modal-title ms-auto">
                {t('admins.invitation_requests.index.approve_invitation_request')}
              </h4>
              <button
                id="close-approve-invitation-request-modal-button"
                type="button"
                className="btn-close me-n3 mt-n5"
                data-bs-dismiss="modal"
                aria-label="Close"
              />
            </div>

            <div className="modal-body fst-italic">
              <div className="mb-4">
                <select
                  className="form-select rounded-pill bg-light"
                  required="required"
                  value={roleToRequest}
                  onChange={handleRoleSelection}
                >
                  <option value="super_admin">{t('activerecord.attributes.admin.roles.super_admin')}</option>
                  <option value="collaborator">{t('activerecord.attributes.admin.roles.collaborator')}</option>
                </select>
              </div>

              <div className="mt-4 text-center">
                <button
                  type="button"
                  className="btn-submit btn btn-primary border-0 shadow mb-1 w-100 text-light rounded-pill"
                  data-bs-dismiss="modal"
                  onClick={() => handleInvitationRequestApproval(emailToRequest, roleToRequest)}
                >
                  {t('admins.invitation_requests.index.send_invitation')}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <ToastContainer
        position="bottom-left"
        autoClose={5000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover={false}
        theme="light"
      />
    </>
  );
};

export default InvitationRequests;
