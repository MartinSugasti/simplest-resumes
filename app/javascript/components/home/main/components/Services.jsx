import React from 'react';

const Services = () => (
  <section id="services" className="bg-primary">
    <div className="container-lg py-5">
      <div className="text-center">
        <h1 className="text-light mb-0">Services</h1>
        <p className="text-light mb-2 fst-italic">Soluciones pensadas para tu comodidad</p>
      </div>

      <div className="row mx-0 gy-4 justify-content-center mt-4">
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-alphabet" />
                <h5 className="card-title">Effective Resumes</h5>
              </div>
              <div>
                <p className="card-text">
                  We help candidates write professional and effective resumes that are tailored to their specific
                  needs and goals.
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3 me-xl-1">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-search" />
                <h5 className="card-title">Search Optimization</h5>
              </div>
              <div>
                <p className="card-text">
                  Recruiters can look for candidates by keywords and save their resumes by job positions, skills,
                  experience, etc.
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-card-checklist" />
                <h5 className="card-title">Postulations Managment</h5>
              </div>
              <div>
                <p className="card-text">
                  Candidates can postulate to jobs and Recruiters can manage these postulations.
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-currency-dollar" />
                <h5 className="card-title">Free</h5>
              </div>
              <div>
                <p className="card-text">
                  All features are free. We accept payments from Candidates to prioritize their resumes when Recruiters
                  look for their skills.
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-10 col-sm-5 col-md-4 col-xl-3">
          <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
            <div className="card-body">
              <div className="mb-4">
                <i className="bi fa-2x bi-magic" />
                <h5 className="card-title">Simplicity</h5>
              </div>
              <div>
                <p className="card-text">
                  We want to keep things simple. We trully think these few features are the basics need for Recruiters
                  findinf the ideal Candiates, and for Candidates finding their perfect job.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
);

export default Services;
