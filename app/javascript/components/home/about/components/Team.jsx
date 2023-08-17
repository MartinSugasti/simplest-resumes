import React from 'react';

import TeamCard from './TeamCard';

import generalImage from '../../../../images/team/general.png';
import JLImage from '../../../../images/team/JL.png';
import jimeImage from '../../../../images/team/jime.png';

const Team = () => (
  <section id="team">
    <div className="container-lg py-5">
      <div className="text-center text-light">
        <h1>Nuestro Equipo</h1>
      </div>

      <div className="row mx-0 g-3 g-sm-4 g-md-5 g-xl-4 justify-content-center mt-4">
        <div className="col-6 col-sm-5 col-xl-3">
          <TeamCard
            name="Jose Luis Urse"
            position="Director"
            image={JLImage}
            email="jlurse@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3">
          <TeamCard
            name="Jimena Urse"
            position="Coordinación General"
            image={jimeImage}
            email="jimenaurse@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3 me-xl-1">
          <TeamCard
            name="Anabel Buffa"
            position="Siniestros"
            image={generalImage}
            email="abuffa@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3">
          <TeamCard
            name="Andreina Navarro"
            position="Seguros de Viajeros y SOA"
            image={generalImage}
            email="anavarro@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3">
          <TeamCard
            name="Javier Osvalde"
            position="Cobranzas"
            image={generalImage}
            email="josvalde@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3 me-xl-1">
          <TeamCard
            name="Maicol Bruno"
            position="Comercial"
            image={generalImage}
            email="mbruno@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3">
          <TeamCard
            name="Santiago Ippes"
            position="Comercial"
            image={generalImage}
            email="sippes@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>

        <div className="col-6 col-sm-5 col-xl-3">
          <TeamCard
            name="Matias Luengo"
            position="Comercial"
            image={generalImage}
            email="mluengo@urseseguros.com.uy"
            linkedinUrl="https://www.linkedin.com/company/urse-seguros/"
          />
        </div>
      </div>
    </div>
  </section>
);

export default Team;
