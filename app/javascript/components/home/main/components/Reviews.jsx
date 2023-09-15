import React from 'react';
import Slider from 'react-slick';

import reviewsImage from '../../../../images/others/reviews.png';

const Reviews = () => {
  const settings = {
    arrows: false,
    autoplay: true,
    dots: true,
    infinite: true,
    speed: 1000,
    autoplaySpeed: 15000,
    slidesToShow: 1,
    slidesToScroll: 1
  };

  return (
    <section id="reviews" className="bg-light">
      <div className="container-lg py-5">
        <div className="text-center">
          <h1 className="text-dark mb-0">Reviews</h1>
          <p className="text-dark mb-2 fst-italic">Qué dicen nuestros clientes</p>
        </div>

        <div className="row mx-0 justify-content-around align-items-center">
          <div className="col-10 col-sm-8 col-md-6 text-center mt-3 mt-md-0 p-0 p-md-3">
            <img src={reviewsImage} className="img-fluid" alt="reviews" />
          </div>

          <div className="col-10 col-sm-8 col-md-6 bg-light rounded text-center slider-container pb-4 mt-4 mt-md-0">
            {/* eslint-disable-next-line react/jsx-props-no-spreading */}
            <Slider {...settings}>
              <div className="text-center text-dark">
                <q className="fst-italic">La amabilidad con la que fui atendida frente al reclamo por el choque de mi vehículo por parte de quien me atendió “Anabel”. La misma me mantuvo al tanto del seguimiento del proceso con muchísima paciencia frente a mis múltiples preguntas por desconocimiento de este tipo de situación teniendo la misma un resultado positivo a mi favor</q>
                <p className="mt-4">Esteban Hernández</p>
              </div>
              <div className="text-center text-dark">
                <q className="fst-italic">Un seguimiento diario de mi expediente, que culminó en el pago del siniestro en tiempo y forma por parte del BSE</q>
                <p className="mt-4">Florencia Pérez, Directora en Óptica del Sol</p>
              </div>
              <div className="text-center text-dark">
                <q className="fst-italic">Tuve una experiencia muy buena tanto con el mecánico chófer de grúa y telefonista. Agradecida con todos ellos</q>
                <p className="mt-4">Ramiro Martínez, Gerente en Céramicas Luiggi</p>
              </div>
              <div className="text-center text-dark">
                <q className="fst-italic">Excelente corredor de seguros que brindan información, atendiendo las inquietudes del cliente. Dejando siempre tiempo para procesar y dialogar en familia y contactarnos nuevamente para una respuesta</q>
                <p className="mt-4">Marta González</p>
              </div>
              <div className="text-center text-dark">
                <q className="fst-italic">Excelente atención, muy ejecutivos a la hora de responder al cliente con prontitud y certeza</q>
                <p className="mt-4">Martin Ramos</p>
              </div>
              <div className="text-center text-dark">
                <q className="fst-italic">Excelente atención, especialmente, encargado de nuestros problemas, Maicol. Gracias por la atención y amabilidad así como también la rapidez en resolución de inquietudes</q>
                <p className="mt-4">Agustina Rivero, Socio de Rivero Transportes</p>
              </div>
            </Slider>

            <div className="mt-5">
              <a href="https://search.google.com/local/writereview?placeid=ChIJE77fArECoZURL5cFhUl1bRA" className="soa-link btn btn-outline-primary-dark rounded-pill" alt="dejanos-tu-opinion" target="_blank" rel="noreferrer">
                <p className="my-0">Déjanos tu opinión</p>
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Reviews;
