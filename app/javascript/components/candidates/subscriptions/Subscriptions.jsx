import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

import Toaster, { showErrorToast, showSuccessToast } from '../../shared/Toaster';
import Loader from '../../shared/Loader';

import { getPlans, postSubscription } from './api';

const Subscriptions = () => {
  const [subscriptionData, setSubscriptionData] = useState({});
  const [plans, setPlans] = useState([]);

  const { t } = useTranslation();

  useEffect(() => {
    getPlans().then((response) => {
      setSubscriptionData(response.data.subscription_data);
      setPlans(response.data.prices);
    }).catch((error) => console.log(error));
  }, []);

  useEffect(() => {
    // Check to see if this is a redirect back from Checkout
    const query = new URLSearchParams(window.location.search);

    if (query.get('success')) {
      showSuccessToast(t('candidates.subscriptions.index.checkout_success'));
    }

    if (query.get('canceled')) {
      showErrorToast(t('candidates.subscriptions.index.checkout_canceled'));
    }
  }, [t]);

  const handleSubscriptionPayment = (event, planId) => {
    event.preventDefault();

    postSubscription(planId).then((response) => {
      window.location.href = response.data.url;
    });
  };

  return (
    <>
      {plans.length === 0 ? (
        <div className="align-items-center d-flex justify-content-center my-5 py-5"><Loader /></div>
      ) : (
        <>
          {subscriptionData.active && (
            <div className="text-center">
              <i className="bi bi-check-circle fa-4x text-success" />
              <h3 className="mb-1">
                {t('candidates.subscriptions.index.subscription_ends_at')}
                {' '}
                {subscriptionData.ends_at}
              </h3>
              <p
                className="mb-4"
                // eslint-disable-next-line max-len, react/no-danger
                dangerouslySetInnerHTML={{ __html: t('candidates.subscriptions.index.manage_subscription_at_the_billing_portal') }}
              />
            </div>
          )}

          <div className="row justify-content-center">
            {plans && plans.map((plan, index) => (
              <form
                onSubmit={(event) => handleSubscriptionPayment(event, plan.id)}
                key={plan.id}
                className={`col-8 col-sm-4 ${plans.length === index + 1 ? 'mt-sm-0 mt-3' : ''}`}
              >
                <div className="card h-100 text-center">
                  <div className="card-body d-flex flex-column">
                    <h1 className="fw-normal">{t(`candidates.subscriptions.index.${plan.lookup_key}`)}</h1>
                    <h2>
                      €
                      {plan.unit_amount / 100}
                    </h2>
                    <ul className="list-unstyled">
                      <li>{t('candidates.subscriptions.index.unlimited_job_postulations')}</li>
                      {plan.lookup_key === 'yearly' && (
                        <li>{t('candidates.subscriptions.index.two_months_free')}</li>
                      )}
                    </ul>
                    <button
                      type="submit"
                      // eslint-disable-next-line max-len
                      className={`w-100 btn btn-primary text-light mt-auto ${subscriptionData.active ? 'disabled' : ''}`}
                    >
                      {t('candidates.subscriptions.index.subscribe')}
                    </button>
                  </div>
                </div>
              </form>
            ))}
          </div>
        </>
      )}

      <Toaster />
    </>
  );
};

export default Subscriptions;
