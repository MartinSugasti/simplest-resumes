import React from 'react';

import LinkWithLoaderAndScrolling from './LinkWithLoaderAndScrolling';

import mainWithoutTextLogo from '../../../images/logos/main_without_text.png';
import cuaproseLogo from '../../../images/partners_logos/cuaprose.svg';
import aproaseTextLogo from '../../../images/partners_logos/aproase.png';

const Footer = () => (
  <section id="footer" className="bg-dark">
    <div className="container-lg pt-5 pb-3">
      <div className="row mx-0 justify-content-around">
        <div className="col-12 col-sm-6 col-md-7 row mx-0 justify-content-center">
          <div className="bg-light partners-container text-dark row text-center mb-4 rounded p-3">
            <p className="col-12 mb-3 mb-sm-0">Integrantes de</p>
            <div className="col-12 row mx-0 justify-content-center">
              <div className="col-6 col-sm-8 col-md-6 align-self-center mt-sm-3">
                <a href="http://aproase.com.uy/" alt="link-to-aproase" target="_blank" rel="noreferrer">
                  <img src={aproaseTextLogo} className="img-fluid logo aproase-img" alt="aproase-logo" />
                </a>
              </div>
              <div className="col-6 col-sm-8 col-md-6 align-self-center mt-sm-3">
                <a href="https://cuaprose.com.uy/" alt="link-to-cuaprose" target="_blank" rel="noreferrer">
                  <img src={cuaproseLogo} className="img-fluid logo cuaprose-img" alt="cuaprose-logo" />
                </a>
              </div>
            </div>
          </div>

          <div>
            <p className="text-light mb-1">
              <a
                href="mailto:info@urseseguros.com.uy"
                className="email-link text-light"
                target="_blank"
                rel="noreferrer"
              >
                <i className="bi bi-envelope-fill me-2" />
                info@urseseguros.com.uy
              </a>
            </p>
            <p className="text-light mb-1">
              <a
                href="https://wa.me/59899804290"
                className="mobile-link text-light"
                target="_blank"
                rel="noreferrer"
              >
                <i className="bi bi-phone me-2" />
                099804290
              </a>
            </p>
            <p className="text-light mb-1">
              <a className="mobile-link text-light" href="tel:43525955">
                <i className="bi bi-telephone-fill me-2" />
                43525955
              </a>
            </p>
            <p className="text-light mb-1 d-flex">
              <a
                href="https://www.google.com/maps/place/Urse+Seguros/@-34.0964304,-56.2206326,17z/data=!3m1!4b1!4m6!3m5!1s0x95a102b102dfbe13:0x106d75498505972f!8m2!3d-34.0964304!4d-56.2180577!16s%2Fg%2F1ptwh97l_"
                className="address-link text-light"
                target="_blank"
                rel="noreferrer"
              >
                <i className="bi bi-signpost me-2" />
                <span>Ursino Barreiro 3452, Florida, Uruguay</span>
              </a>
            </p>
            <p className="text-light mb-1">
              <a
                href="#horarios-modal"
                alt="horarios"
                data-bs-toggle="modal"
                data-bs-target="#horarios-modal"
                className="mobile-link text-light"
              >
                <i className="bi bi-calendar me-2" />
                Ver horarios
              </a>
            </p>
          </div>

          <div className="text-light align-self-end mt-4 mt-sm-1">
            <a href="https://www.linkedin.com/company/urse-seguros/" alt="link-to-urseseguros-linkedin" target="_blank" rel="noreferrer">
              <i className="text-light bi bi-linkedin fa-2x me-3 me-md-4" />
            </a>
            <a href="https://www.instagram.com/urse_seguros/" alt="link-to-urseseguros-instagram" target="_blank" rel="noreferrer">
              <i className="text-light bi bi-instagram fa-2x me-3 me-md-4" />
            </a>
            <a href="https://twitter.com/UrseSeguros" alt="link-to-urseseguros-twitter" target="_blank" rel="noreferrer">
              <i className="text-light bi bi-twitter fa-2x me-3 me-md-4" />
            </a>
            <a href="https://www.facebook.com/ursesegurosflorida" alt="link-to-urseseguros-facebook" target="_blank" rel="noreferrer">
              <i className="text-light bi bi-facebook fa-2x me-3 me-md-4" />
            </a>
          </div>
        </div>

        <div className="col-12 col-sm-6 col-md-5 google-map-container mt-4 mt-sm-0">
          <div className="google-map">
            <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3303.94964922759!2d-56.222928612070355!3d-34.096430303885!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x95a102b102dfbe13%3A0x106d75498505972f!2sUrse%20Seguros!5e0!3m2!1sen!2ses!4v1684919639860!5m2!1sen!2ses"
              title="google map"
              allowFullScreen=""
              referrerPolicy="no-referrer-when-downgrade"
              className="rounded"
            />
          </div>
        </div>
      </div>

      <div className="row justify-content-center mt-4 pt-3 mx-3 mx-lg-0 border-top">
        <LinkWithLoaderAndScrolling to="/" className="btn btn-link col-6 col-sm-3 col-md-2" sectionId="main-intro">
          <img src={mainWithoutTextLogo} className="img-fluid logo" alt="main-logo" />
        </LinkWithLoaderAndScrolling>
      </div>

      <div className="modal fade" id="horarios-modal" tabIndex="-1" aria-labelledby="modal-title" aria-hidden="true">
        <div className="modal-dialog modal-dialog-centered modal-lg">
          <div className="modal-content bg-light text-dark p-1 p-sm-2 p-lg-3">
            <div className="modal-header border-0">
              <h4 className="modal-title ms-auto" id="modal-horarios-title">Horarios de Atención</h4>
              <button type="button" className="btn-close me-n3 mt-n5" data-bs-dismiss="modal" aria-label="Close" />
            </div>
            <div className="modal-body text-center mx-sm-5">
              <table className="table table-striped table table-bordered">
                <thead className="thead">
                  <tr>
                    <th>Día</th>
                    <th>Horario</th>
                  </tr>
                </thead>
                <tbody className="table table-striped">
                  <tr>
                    <td>Lunes</td>
                    <td>9:00 - 18:00</td>
                  </tr>
                  <tr>
                    <td>Martes</td>
                    <td>9:00 - 18:00</td>
                  </tr>
                  <tr>
                    <td>Miércoles</td>
                    <td>9:00 - 18:00</td>
                  </tr>
                  <tr>
                    <td>Jueves</td>
                    <td>9:00 - 18:00</td>
                  </tr>
                  <tr>
                    <td>Viernes</td>
                    <td>9:00 - 18:00</td>
                  </tr>
                  <tr>
                    <td>Sábado</td>
                    <td>9:00 - 12:00</td>
                  </tr>
                  <tr>
                    <td>Domingo</td>
                    <td>Cerrado</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
);

export default Footer;
