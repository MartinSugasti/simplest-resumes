import React from 'react';

// For opening the modal, parent component needs an element like the following:
// <a
//   href="#quoter-form"
//   className="privacy-policy-link privacy-policy-link-light"
//   alt="politica-de-privacidad"
//   data-bs-toggle="modal"
//   data-bs-target="#privacy-policy-modal"
// >
//   <p className="small text-light fst-italic mt-1">Política de privacidad</p>
// </a>
const PrivacyPolicy = () => (
  <div className="modal fade" id="privacy-policy-modal" tabIndex="-1" aria-labelledby="modal-title" aria-hidden="true">
    <div className="modal-dialog modal-dialog-centered modal-lg">
      <div className="modal-content bg-light text-dark p-1 p-sm-2 p-lg-3">
        <div className="modal-header border-0">
          <h4 className="modal-title ms-auto" id="modal-privacy-policy-title">Política de Privacidad</h4>
          <button type="button" className="btn-close me-n3 mt-n5" data-bs-dismiss="modal" aria-label="Close" />
        </div>
        <div className="modal-body fst-italic">
          <p>
            {/* eslint-disable-next-line max-len */}
            Urse Seguros realiza el tratamiento de los datos personales de su web y app conforme a los dispuesto en la Ley Nº 18.331, de 11 de agosto de 2008 , y el Decreto Nº 414/009, de 21 de agosto de 2009, sobre protección de datos personales y Habeas Data. Toda la gestión de los datos se realizan de acuerdo a las disposiciones allí establecidas.
          </p>
          <p>
            {/* eslint-disable-next-line max-len */}
            Los datos personales como nombre, dirección de mail y numero de celular serán utilizados con la única finalidad de brindar correctamente el servicio de asesoramiento en seguros y la mejora en el uso de las herramientas de contacto y asesoría: como newsletter, encuestas y sitio web. Los demás datos solicitados únicamente serán utilizados con fines contractuales.
          </p>
          <p>
            {/* eslint-disable-next-line max-len */}
            Única y exclusivamente cuando el cliente dé su consentimiento, o lo requiera por la consecución perseguida, los datos personales recabados podrán ser comunicados a agentes externos.
          </p>
          <p>
            {/* eslint-disable-next-line max-len */}
            Urse Seguros garantiza a sus usuarios el derecho de acceso, rectificación, actualización, inclusión y supresión que otorga la Ley N° 18.331. A través de cualquier línea de contacto.
          </p>
          <p>
            {/* eslint-disable-next-line max-len */}
            Urse Seguros podrá utilizar cookies en su sitio web cuando el usuario acceda desde un navegador que así lo permita, con el único objetivo de la mejora en la experiencia. Si el usuario lo desea puede modificar la configuración del navegador para impedirlo.
          </p>
          <p>
            {/* eslint-disable-next-line max-len */}
            Esta Política de Privacidad se aplica únicamente a la información gestionada en el sitio web y la app de Urse Seguros, no se extiende a enlaces externos a otros sitios web.
          </p>
        </div>
      </div>
    </div>
  </div>
);

export default PrivacyPolicy;