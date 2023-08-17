import React from 'react';

import bseImage from '../../../../images/companies_logos/bse.svg';
import hdiImage from '../../../../images/companies_logos/hdi.svg';
import mapfreImage from '../../../../images/companies_logos/mapfre.svg';
import portoImage from '../../../../images/companies_logos/porto.svg';
import sanCristobalImage from '../../../../images/companies_logos/san_cristobal.svg';
import sancorImage from '../../../../images/companies_logos/sancor.svg';
import suraImage from '../../../../images/companies_logos/sura.svg';
import sbiImage from '../../../../images/companies_logos/sbi.svg';
import surcoImage from '../../../../images/companies_logos/surco.png';
import berkleyImage from '../../../../images/companies_logos/berkley.png';

// For opening the modal, parent component needs an element like the following:
// <a
//   href="#intro"
//   className="accident-link btn btn-danger rounded-pill mt-2"
//   alt="en-caso-de-accidente"
//   data-bs-toggle="modal"
//   data-bs-target="#accident-modal"
// >
//   <p className="my-0">En caso de siniestro</p>
// </a>

const AccidentModal = () => (
  <div className="modal fade" id="accident-modal" tabIndex="-1" aria-labelledby="modal-title" aria-hidden="true">
    <div className="modal-dialog modal-dialog-centered modal-lg">
      <div className="modal-content bg-light text-dark p-1 p-sm-2 p-lg-3">
        <div className="modal-header border-0">
          <h4 className="modal-title ms-auto" id="modal-contacto-companias-title">En caso de siniestro o auxilio mecánico:</h4>
          <button type="button" className="btn-close me-n3 mt-n5" data-bs-dismiss="modal" aria-label="Close" />
        </div>

        <div className="modal-body">
          <p className="bg-danger bg-opacity-25 border border-1 border-danger fw-semibold px-1 py-2 rounded">
            Siempre realizar denuncia en la compañía de seguros en forma inmediata.
          </p>
          <p>
            Si hay lesionados prestar asistencia médica y efectuar la denuncia policial.
          </p>
          <p>
            Si viajas al exterior: llevar toda la documentación,
            {' '}
            incluido el Certificado Mercosur (carta verde).
          </p>

          <div className="mt-5">
            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://bse.com.uy/" alt="link-to-bse-page" target="_blank" rel="noreferrer">
                  <img src={bseImage} className="m-auto" alt="bse-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08001994">0800-1994 </a>
                  o
                  <a className="text-primary-dark" href="tel:*1994">*1994</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59826141555">(+598) 2614-1555</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.sancorseguros.com.uy/" alt="link-to-sancor-page" target="_blank" rel="noreferrer">
                  <img src={sancorImage} className="m-auto" alt="sancor-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08008500">0800-8500</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59826280444">(+598) 2628-0444</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.portoseguro.com.uy/" alt="link-to-porto-page" target="_blank" rel="noreferrer">
                  <img src={portoImage} className="m-auto" alt="porto-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:24878616">2487-8616 </a>
                  o
                  <a className="text-primary-dark" href="tel:*76786"> *76786</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59824878616">(+598) 2487-8616</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.hdi.com.uy/" alt="link-to-hdi-page" target="_blank" rel="noreferrer">
                  <img src={hdiImage} className="m-auto" alt="hdi-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08002777">0800-2777</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59826188000">(+598) 2618-8000</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://sura.com.uy/" alt="link-to-sura-page" target="_blank" rel="noreferrer">
                  <img src={suraImage} className="m-auto" alt="sura-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08008120">0800-8120</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59826059020">(+598) 2605-9020</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.surco.com.uy/" alt="link-to-surco-page" target="_blank" rel="noreferrer">
                  <img src={surcoImage} className="m-auto" alt="surco-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08001320">0800-1320</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59829159671">(+598) 2915-9671</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.berkley.com.uy/" alt="link-to-berkley-page" target="_blank" rel="noreferrer">
                  <img src={berkleyImage} className="m-auto" alt="berkley-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08008542">0800-8542</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59829040658">(+598) 2904-0658</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.mapfre.com.uy/" alt="link-to-mapfre-page" target="_blank" rel="noreferrer">
                  <img src={mapfreImage} className="m-auto" alt="mapfre-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08007424">0800-7424</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59829169245">(+598) 2916-9245</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center border border-1 border-end-0 border-start-0 border-top-0 pb-4 mb-4">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.sancristobalseguros.com.uy" alt="link-to-san-cristobal-page" target="_blank" rel="noreferrer">
                  <img src={sanCristobalImage} className="m-auto" alt="san-cristobal-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08008831">0800-8831</a>
                </p>
                <p className="mb-0">Desde el exterior:</p>
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:+59829029999">(+598) 2902-9999</a>
                </p>
              </div>
            </div>

            <div className="row align-items-center justify-content-center pb-2 pb-sm-0">
              <div className="d-flex justify-content-center col-6">
                <a href="https://www.sbi.uy/" alt="link-to-sbi-page" target="_blank" rel="noreferrer">
                  <img src={sbiImage} className="m-auto" alt="sbi-logo" />
                </a>
              </div>

              <div className="col-6 small text-center">
                <p className="mb-0">
                  <a className="text-primary-dark" href="tel:08000724">0800-0724 </a>
                  o
                  <a className="text-primary-dark" href="tel:094724724"> 094-724-724</a>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
);

export default AccidentModal;
