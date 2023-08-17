import React from 'react';

import bseImage from '../../../../images/companies_logos/bse.svg';
import hdiImage from '../../../../images/companies_logos/hdi.svg';
import mapfreImage from '../../../../images/companies_logos/mapfre.svg';
import portoImage from '../../../../images/companies_logos/porto.svg';
import sancorImage from '../../../../images/companies_logos/sancor.svg';
import suraImage from '../../../../images/companies_logos/sura.svg';
import surcoImage from '../../../../images/companies_logos/surco.png';

// For opening the modal, parent component needs an element like the following:
// <a
//   href="#intro"
//   className="soa-link btn btn-outline-primary-dark rounded-pill mt-2"
//   alt="imprimir-soa"
//   data-bs-toggle="modal"
//   data-bs-target="#soa-modal"
// >
//   <p className="my-0">SOA y Carta Verde</p>
// </a>

const SoaModal = () => (
  <div className="modal fade" id="soa-modal" tabIndex="-1" aria-labelledby="modal-title" aria-hidden="true">
    <div className="modal-dialog modal-dialog-centered modal-lg">
      <div className="modal-content bg-light text-dark p-1 p-sm-2 p-lg-3">
        <div className="modal-header border-0">
          <h4 className="modal-title ms-auto" id="modal-contacto-companias-title">Certificado SOA y Mercosur (carta verde)</h4>
          <button type="button" className="btn-close me-n3 mt-n5" data-bs-dismiss="modal" aria-label="Close" />
        </div>

        <div className="modal-body">
          <p>
            Para acceder a tus certificados, en algunas compañías tendrás que estar registrado.
          </p>

          <div className="row mx-0 mt-4 justify-content-center g-2">
            <a href="https://bse.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={bseImage} className="m-auto" alt="bse-logo" />
              </div>
            </a>

            <a href="https://www.sancorseguros.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={sancorImage} className="m-auto" alt="sura-logo" />
              </div>
            </a>

            <a href="https://www.portoseguro.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={portoImage} className="m-auto" alt="porto-logo" />
              </div>
            </a>

            <a href="https://www.hdi.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={hdiImage} className="m-auto" alt="hdi-logo" />
              </div>
            </a>

            <a href="https://sura.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={suraImage} className="m-auto" alt="sura-logo" />
              </div>
            </a>

            <a href="https://www.surco.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={surcoImage} className="m-auto" alt="surco-logo" />
              </div>
            </a>

            <a href="https://www.mapfre.com.uy/" alt="link-to-company-page" target="_blank" rel="noreferrer" className="col-5 col-lg-4 d-flex justify-content-center border m-2 p-3 rounded-2 shadow">
              <div>
                <img src={mapfreImage} className="m-auto" alt="mapfre-logo" />
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
);

export default SoaModal;