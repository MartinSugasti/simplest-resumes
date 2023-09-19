import React, { useState } from 'react';
import { useLocation } from 'react-router-dom';

import ContactForm from '../../shared/ContactForm';
import CarInsuranceFields from './CarInsuranceFields';
import TravelInsuranceFields from './TravelInsuranceFields';
import HomeInsuranceFields from './HomeInsuranceFields';
import BusinessInsuranceFields from './BusinessInsuranceFields';
import OthersInsuranceFields from './OthersInsuranceFields';
import LifeAndSavingsInsuranceFields from './LifeAndSavingsInsuranceFields';

const fieldsComponentMapping = {
  'Seguros de Automóviles': CarInsuranceFields,
  'Seguros de Viaje': TravelInsuranceFields,
  'Seguros de Ahorro y Vida': LifeAndSavingsInsuranceFields,
  'Seguros para Comercios': BusinessInsuranceFields,
  'Seguros de Hogar': HomeInsuranceFields,
  'Seguros Agropecuarios': OthersInsuranceFields,
  Otros: OthersInsuranceFields
};

const fieldsListMapping = {
  'Seguros de Automóviles': ['marca', 'modelo', 'year', 'estado', 'location', 'fuel', 'category', 'antirrobo', 'motivo', 'company'],
  'Seguros de Viaje': ['destino', 'duracion', 'pasajeros'],
  'Seguros de Ahorro y Vida': ['profesion', 'hobby', 'monto', 'proteccion'],
  'Seguros para Comercios': ['location', 'actividad'],
  'Seguros de Hogar': ['location', 'tipo', 'destino'],
  'Seguros Agropecuarios': [],
  Otros: []
};

const QuoterContactForm = () => {
  const { search } = useLocation();
  const [insuranceType, setInsuranceType] = useState(new URLSearchParams(search).get('insurance_type') || 'Seguros de Automóviles');

  const FieldsComponent = fieldsComponentMapping[insuranceType];

  const handleInsuranceTypeSelection = (event) => {
    setInsuranceType(event.target.value);
  };

  return (
    <section id="quoter-form">
      <div className="container-lg py-5">
        <ContactForm
          title="Cotizar"
          subtitle="Completa los datos y te responderemos a la brevedad"
          theme="light"
          insuranceType={insuranceType}
          handleInsuranceTypeSelection={handleInsuranceTypeSelection}
          fieldsList={fieldsListMapping[insuranceType]}
        >
          {insuranceType && <FieldsComponent /> }
        </ContactForm>
      </div>
    </section>
  );
};

export default QuoterContactForm;
