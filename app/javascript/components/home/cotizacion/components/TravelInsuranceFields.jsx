import React from 'react';

const TravelInsuranceFields = () => (
  <>
    <div className="row mx-0">
      <div className="col-12 col-md-6 ps-0 pe-0 pe-md-1">
        <div className="mb-3 input-group">
          <input type="text" name="destino" id="destino" className="form-control bg-light" placeholder="Destino del Viaje" required />
        </div>
      </div>

      <div className="col-12 col-md-6 ps-0 ps-md-1 pe-0">
        <div className="mb-3 input-group">
          <select className="form-select text-dark bg-light" id="duracion" name="duracion" defaultValue="" required>
            <option value="" disabled>Duración</option>
            <option value="Menos de 1 Mes">Menos de 1 mes</option>
            <option value="1 Mes">1 Mes</option>
            <option value="2 Meses">2 Meses</option>
            <option value="3 Meses">3 Meses</option>
            <option value="Entre 3 y 6 Meses">Entre 3 y 6 Meses</option>
            <option value="Entre 6 Meses y 1 Año">Entre 6 Meses y 1 Año</option>
            <option value="Mas de 1 Año">Mas de 1 Año</option>
            <option value="Aún no lo sé">Aún no lo sé</option>
          </select>
        </div>
      </div>
    </div>

    <div className="row mx-0">
      <div className="col-12 col-md-6 ps-0 pe-0 pe-md-1">
        <div className="mb-3 input-group">
          <select className="form-select text-dark bg-light" id="pasajeros" name="pasajeros" defaultValue="" required>
            <option value="" disabled>Cantidad de Pasajeros</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="Mas de 5">Mas de 5</option>
          </select>
        </div>
      </div>
    </div>
  </>
);

export default TravelInsuranceFields;
