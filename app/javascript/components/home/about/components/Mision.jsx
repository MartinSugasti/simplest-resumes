/* eslint-disable max-len */
import React from 'react';

import missionImage from '../../../../images/others/mission.png';

const Mision = () => (
  <section id="mision" className="bg-primary">
    <div className="container-lg py-5">
      <div className="row mx-0 justify-content-around align-items-center">
        <div className="col-11 col-sm-9 col-md-6 text-center">
          <div className="accordion accordion-flush panel-group" id="accordionFlushExample">
            <div className="accordion-item panel bg-transparent border border-2 border-light">
              <h2 className="accordion-header panel-heading" id="flush-headingOne">
                <button className="accordion-button collapsed panel-title rounded-2 text-center bg-transparent" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                  Misión
                  <span> </span>
                </button>
              </h2>
              <div id="flush-collapseOne" className="accordion-collapse collapse panel-collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                <div className="accordion-body text-light py-0 px-2 fst-italic">Somos una empresa con una amplia trayectoria en el medio, que desde 1987 se dedica al asesoramiento y venta de seguros.</div>
                <div className="accordion-body text-light px-2 fst-italic">Trabajamos con todas las compañías de seguros contando por parte de éstas con el respaldo y el aval suficiente, merced a nuestro trabajo profesional a lo largo de todos estos años. Ofrecemos soluciones confiables, a la medida de cada uno de nuestros clientes,  brindando  un servicio personalizado, responsable y de calidad.</div>
              </div>
            </div>
            <div className="accordion-item panel bg-transparent border border-2 border-light">
              <h2 className="accordion-header panel-heading" id="flush-headingTwo">
                <button className="accordion-button collapsed panel-title rounded-2 text-center bg-transparent" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                  Visión
                  <span> </span>
                </button>
              </h2>
              <div id="flush-collapseTwo" className="accordion-collapse collapse panel-collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                <div className="accordion-body text-light py-0 px-2 fst-italic">Mantener el liderazgo siendo referentes en el mercado de los seguros, dentro de un marco técnico y legal, y conforme a nuestros valores. Ser la “MARCA EN SEGUROS”; una empresa eficiente y competitiva, especialistas en seguros, líderes en servicio.</div>
                <div className="accordion-body text-light px-2 fst-italic">Proporcionar un alto grado de confianza, tranquilidad y seguridad prestando un servicio de excelencia acorde a las expectativas de nuestros clientes. Ofrecer respuestas efectivas y oportunas. Afianzar el vínculo con el cliente, lograr empatía y la fidelización del mismo.</div>
              </div>
            </div>
          </div>
        </div>
        <div className="col-12 col-md-6 order-md-first text-center align-self-end mb-n5">
          <img src={missionImage} className="img-fluid" alt="mission" />
        </div>
      </div>
    </div>
  </section>
);

export default Mision;
