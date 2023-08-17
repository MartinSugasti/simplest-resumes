import React from 'react';

const HomeInsuranceFields = () => (
  <>
    <div className="row mx-0">
      <div className="col-12 col-md-6 ps-0 pe-0 pe-md-1">
        <div className="mb-3 input-group">
          <select className="form-select text-dark bg-light" id="location" name="location" defaultValue="" required>
            <option value="" disabled>Departamento</option>
            <option value="Montevideo y A. Metropol.">Montevideo y Área Metropolitana</option>
            <option value="Artigas">Artigas</option>
            <option value="Canelones">Canelones</option>
            <option value="Cerro Largo">Cerro Largo</option>
            <option value="Colonia">Colonia</option>
            <option value="Durazno">Durazno</option>
            <option value="Flores">Flores</option>
            <option value="Florida">Florida</option>
            <option value="Lavalleja">Lavalleja</option>
            <option value="Maldonado">Maldonado</option>
            <option value="Paysandu">Paysandu</option>
            <option value="Rio Negro">Rio Negro</option>
            <option value="Rivera">Rivera</option>
            <option value="Rocha">Rocha</option>
            <option value="Salto">Salto</option>
            <option value="San Jose">San Jose</option>
            <option value="Soriano">Soriano</option>
            <option value="Tacuarembo">Tacuarembo</option>
            <option value="Treinta y Tres">Treinta y Tres</option>
          </select>
        </div>
      </div>

      <div className="col-12 col-md-6 ps-0 ps-md-1 pe-0">
        <div className="mb-3 input-group">
          <select className="form-select text-dark bg-light" id="tipo" name="tipo" defaultValue="">
            <option value="" disabled>Tipo de Vivienda</option>
            <option value="Casa o Apartamento en PB o 1er Piso">Casa o Apartamento en PB o 1er Piso</option>
            <option value="Apartamento a partir del 2do Piso">Apartamento a partir del 2do Piso</option>
            <option value="Otro">Otro</option>
          </select>
        </div>
      </div>
    </div>

    <div className="row mx-0">
      <div className="col-12 col-md-6 ps-0 pe-0 pe-md-1">
        <div className="mb-3 input-group">
          <select className="form-select text-dark bg-light" id="destino" name="destino" defaultValue="" required>
            <option value="" disabled>Destino de la Vivienda</option>
            <option value="Permanente">Uso Propio Permanente</option>
            <option value="Transitorio">Uso Propio Transitorio</option>
            <option value="Alquiler">Alquiler</option>
          </select>
        </div>
      </div>
    </div>
  </>
);

export default HomeInsuranceFields;
