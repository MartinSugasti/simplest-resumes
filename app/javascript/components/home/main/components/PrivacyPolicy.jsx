import React from 'react';
import { useTranslation } from 'react-i18next';

import PrivacyPolicyContentEn from './PrivacyPolicyContentEn';
import PrivacyPolicyContentEs from './PrivacyPolicyContentEs';

// For opening the modal, parent component needs an element like the following:
// <a
//   href="#quoter-form"
//   className="privacy-policy-link"
//   alt="politica-de-privacidad"
//   data-bs-toggle="modal"
//   data-bs-target="#privacy-policy-modal"
// >
//   <p className="small text-light fst-italic mt-1">Privacy Policy</p>
// </a>
const PrivacyPolicy = () => {
  const { t, i18n } = useTranslation();

  return (
    <div
      id="privacy-policy-modal"
      className="modal fade"
      tabIndex="-1"
      aria-labelledby="modal-title"
      aria-hidden="true"
    >
      <div className="modal-dialog modal-dialog-centered modal-lg">
        <div className="modal-content bg-light text-dark p-1 p-sm-2 p-lg-3">
          <div className="modal-header border-0">
            <h2 className="modal-title ms-auto" id="modal-privacy-policy-title">
              {t('pages.home.privacy_policy.title')}
            </h2>

            <button type="button" className="btn-close me-n3 mt-n5" data-bs-dismiss="modal" aria-label="Close" />
          </div>

          {i18n.resolvedLanguage === 'es' ? (
            <PrivacyPolicyContentEs />
          ) : (
            <PrivacyPolicyContentEn />
          )}
        </div>
      </div>
    </div>
  );
};

export default PrivacyPolicy;
