import React from 'react';

const Servicios = () => (
  <section id="servicios" className="bg-primary">
    <div className="container-lg py-5">
      <div className="text-center">
        <h1 className="text-light mb-0">Servicios</h1>
        <p className="text-light mb-2 fst-italic">Soluciones pensadas para tu comodidad</p>
      </div>

      <div className="row mx-0 gy-4 justify-content-center mt-4">
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-signpost-2" />
                <h5 className="card-title">Gestión de siniestros</h5>
              </div>
              <div>
                <p className="card-text">En caso de siniestro gestionamos y realizamos el seguimiento frente a las compañías, acompañándote en todo momento, hasta la finalización del mismo.</p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3 me-xl-1">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-wallet2" />
                <h5 className="card-title">Gestión de Cobranzas</h5>
              </div>
              <div>
                <p className="card-text">Frente a la posibilidad de no pago en fecha de los cupones y/o facturas, te haremos llegar un aviso para evitar el cese de cobertura.</p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-arrow-clockwise" />
                <h5 className="card-title">Gestión de las renovaciones</h5>
              </div>
              <div>
                <p className="card-text">Al llegar el vencimiento de la póliza cotizamos en todas las compañías asegurándote los mejores costos/beneficios.</p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-compass" />
                <h5 className="card-title">Asesoramiento</h5>
              </div>
              <div>
                <p className="card-text">Te informamos y asesoramos sobre todo tipo de seguros, productos y compañías que mejor se adapte a tus necesidades y posibilidades.</p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-phone" />
                <h5 className="card-title">App Móvil y Web</h5>
              </div>
              <div>
                <p className="card-text">Puedes hacer tus consultas y solicitud de cotizaciones desde la comodidad de tu casa o desde donde te encuentres.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
);

export default Servicios;
