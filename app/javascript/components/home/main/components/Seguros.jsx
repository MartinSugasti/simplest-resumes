import React from 'react';

import CarouselCard from './CarouselCard';

import carImage from '../../../../images/insurances/car.png';
import familyLargeImage from '../../../../images/insurances/family.png';
import businessImage from '../../../../images/insurances/business.png';
import homeImage from '../../../../images/insurances/home.png';
import agroImage from '../../../../images/insurances/agro.png';
import travelImage from '../../../../images/insurances/travel.png';

const Seguros = () => (
  <section id="seguros">
    <div className="container-lg py-5">
      <div className="text-center">
        <h1 className="text-light mb-0">Seguros</h1>
        <p className="text-light mb-2 fst-italic text-light">Soluciones pensadas para tu tranquilidad</p>
      </div>

      <div id="carouselExampleControls" className="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
        <div className="carousel-inner m-auto">
          <CarouselCard active image={familyLargeImage} insuranceType="Seguros de Ahorro y Vida">
            <>
              <h4 className="card-title text-center text-sm-start">Seguros de Ahorro y Vida</h4>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Ahorro y Vida
              </h6>
              <p className="card-text small">Elegís el ahorro que querés cobrar al ﬁnal del período y en caso de fallecimiento le paga el capital a los beneﬁciarios</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Renta
              </h6>
              <p className="card-text small">Te aseguras recibir una renta mensual a partir de la fecha que elegís al momento de contratarlo. También tenés la opción de retirar el capital generado al contado</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Accidente
              </h6>
              <p className="card-text small">Esta solución busca protegerte en todo momento ante eventos inesperados, situaciones que te impiden seguir tu día a día con normalidad</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Salud
              </h6>
              <p className="card-text small">Brinda la posibilidad de complementar la cobertura de salud en caso de tener el diagnóstico de enfermedades graves</p>
            </>
          </CarouselCard>

          <CarouselCard image={homeImage} insuranceType="Seguros de Hogar">
            <>
              <h4 className="card-title text-center text-sm-start">Seguros de Hogar</h4>
              <p className="card-text small">
                El clima, la inseguridad, son peligros latentes.
                {' '}
                <strong>
                  A partir de US$100 anuales puedes asegurar tu casa y objetos contra:
                </strong>
              </p>
              <ul className="list ps-0">
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Incendio
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Incendio de Contenido
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Inclemencias Climáticas
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Daños electricos
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Cristales
                </li>
                <p className="card-text mt-3 small">
                  Con diferentes coberturas, de acuerdo a sus necesidades y posibilidades, estos
                  seguros amparan su hogar contra los riesgos más frecuentes
                </p>
              </ul>
            </>
          </CarouselCard>

          <CarouselCard image={carImage} insuranceType="Seguros de Automóviles">
            <>
              <h4 className="card-title text-center text-sm-start">Seguro de Automóviles</h4>
              <p className="card-text small">Cotizamos su vehículo teniendo en cuenta el mejor costo-beneficio con las más importantes compañías aseguradoras instaladas en nuestro país.</p>
              <p className="card-text small">Aseguramos cualquier tipo de vehículo de acuerdo a las coberturas correspondientes:</p>
              <ul className="list ps-0">
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Seguro Obligatorio (SOA)
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Responsabilidad Civil
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Incendio
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Hurto
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Daño Propio
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Daños Mayores
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Pérdida Total
                </li>
              </ul>
            </>
          </CarouselCard>

          <CarouselCard image={agroImage} insuranceType="Seguros Agropecuarios">
            <>
              <h4 className="card-title text-center text-sm-start">Seguros Agropecuarios</h4>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Agrícola
              </h6>
              <p className="card-text mb-2 small">Coberturas que garantizan indemnización por daños sufridos por factores climáticos</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Vida Animal
              </h6>
              <p className="card-text mb-2 small">Ganado vacuno, ovinos y suinos, equinos, animales de pedigree y toros de cabaña</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Forestación
              </h6>
              <p className="card-text mb-2 small">Coberturas de los riesgos de producción desde la etapa de vivero hasta el retiro de la madera</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Responsabilidad Civil
              </h6>
              <p className="card-text mb-2 small">Por explotación agropecuaria, por cruce y arreo de ganado y escape de animales</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Maquinaria Agrícola y Forestal
              </h6>
              <p className="card-text mb-2 small">Cubre los posibles daños que sufran tus maquinarias</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Otras Coberturas
              </h6>
              <p className="card-text mb-2 small">Seguro Apícola, Silos de Poliuretano, etc.</p>
            </>
          </CarouselCard>

          <CarouselCard image={businessImage} insuranceType="Seguros para Comercios">
            <>
              <h4 className="card-title text-center text-sm-start">Seguros para Comercios</h4>
              <ul className="list ps-0">
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Combinado Comercio
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Flota de Vehículos
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Cristales
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Transporte de Mercadería
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Todo Riesgo Operativo
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Fianza
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Embaraciones y Aviones
                </li>
                <li>
                  <i className="bi bi-check-lg me-1" />
                  Crédito a la Exportación
                </li>
              </ul>
            </>
          </CarouselCard>

          <CarouselCard image={travelImage} insuranceType="Otros">
            <>
              <h4 className="card-title text-center text-sm-start">Otros</h4>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Seguro de Viaje
              </h6>
              <p className="card-text small">Cubre la asistencia médica en ocasión de un viaje, ya sea de placer, turismo o negocios</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Garantía de Alquiler
              </h6>
              <p className="card-text small">Este seguro es una garantía de arrendamiento para quien alquila una casa, apartamento o local comercial, protegiéndose a sí mismo y al propietario del inmueble del posible incumplimiento en el pago del alquiler</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Embarcaciones
              </h6>
              <p className="card-text small">Este seguro está destinado a cubrir todos aquellos barcos que sean utilizados sin fines de lucro (veleros, lanchas, botes, etc.)</p>
              <h6 className="mb-1">
                <i className="bi bi-check-lg me-1" />
                Vehículos Náuticos
              </h6>
              <p className="card-text small">Seguro destinado a cubrir motos náuticas, jet sky, gomones, kayaks, etc.</p>
            </>
          </CarouselCard>
        </div>

        <button className="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
          <span className="carousel-control-prev-icon" aria-hidden="true" />
          <span className="visually-hidden">Previous</span>
        </button>

        <button className="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
          <span className="carousel-control-next-icon" aria-hidden="true" />
          <span className="visually-hidden">Next</span>
        </button>
      </div>
    </div>
  </section>
);

export default Seguros;
