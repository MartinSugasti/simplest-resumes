import React from 'react';

const LifeAndSavingsInsuranceFields = () => (
  <>
    <div className="row mx-0">
      <div className="col-12 col-md-6 ps-0 pe-0 pe-md-1">
        <div className="mb-3 input-group">
          <input type="text" name="profesion" id="profesion" className="form-control bg-light" placeholder="Profesión" required />
        </div>
      </div>

      <div className="col-12 col-md-6 ps-0 ps-md-1 pe-0">
        <div className="mb-3 input-group">
          <input type="text" name="hobby" id="hobby" className="form-control bg-light" placeholder="Hobby" />
        </div>
      </div>
    </div>

    <div className="row mx-0">
      <div className="col-12 col-md-6 ps-0 pe-0 pe-md-1">
        <div className="mb-3 input-group">
          <input type="number" name="monto" className="form-control bg-light" step="1" placeholder="Monto Mensual Dispuesto a Pagar" />
        </div>
      </div>

      <div className="col-12 col-md-6 ps-0 ps-md-1 pe-0">
        <div className="mb-3 input-group">
          <input type="date" id="birthday" name="birthday" className="form-control bg-light" placeholder="Fecha de Nacimiento" required />
        </div>
      </div>
    </div>
  </>
);

export default LifeAndSavingsInsuranceFields;
