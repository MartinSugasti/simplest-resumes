<p align="center">
  <img src="https://github.com/MartinSugasti/simplest-resumes/blob/main/app/assets/images/logos/primary.png" />
</p>

This personal project was undertaken to enhance my proficiency in various technologies and tools commonly employed in web application development. While I had prior experience with many of these components, several were either new to me or had only been explored through tutorials or basic courses. To deepen my understanding and practical skills, I aimed to construct a moderately sized web application from the ground up.

The objective of this project was to integrate all relevant technologies and tools, from configuring the hosting provider and domain to implementing specific web application features. Through this hands-on experience, I sought to expand my capabilities as a full-stack developer.

# Description
This web application facilitates the following functions:
- Recruiters can advertise job postings and search for candidates
- Candidates can generate and download their resumes, as well as postulate to job postings
- Admin users can oversee the application’s various operational aspects

This is a list of key technologies and features:
- [Render](https://render.com/) for hosting
- [Ruby on Rails](https://rubyonrails.org/) for the backend
- [PostgreSQL](https://www.postgresql.org/) as database
- [Redis](https://redis.com/) for in-memory storage
- [Sidekiq](https://sidekiq.org/) for handling background jobs, such as sending SMS to candidates when their job applications are approved
- [Sidekiq-Scheduler](https://github.com/sidekiq-scheduler/sidekiq-scheduler) for scheduled tasks, such as sending reminder emails
- [Devise](https://github.com/heartcombo/devise) for authentication
- [Devise Masquerade](https://github.com/oivoodoo/devise_masquerade) for admins to impersonate candidates and recruiters
- [Omniauth](https://github.com/omniauth/omniauth) for social login with Gmail, Twitter, and GitHub for candidates and recruiters
- [Pundit](https://github.com/varvet/pundit) for authorization
- [Amazon S3](https://aws.amazon.com/) for storing images, such as profile pictures
- [Sendgrid](https://sendgrid.com/) as an SMTP provider
- [Forwardemail](https://forwardemail.net/) for forwarding emails to my personal account. Also, configured my personal account to send emails as support@simplestresumes.com
- [Twilio](https://pages.twilio.com/) for sending SMS notifications
- [Stripe](https://stripe.com/) integration for allowing candidates to subscribe for unlimited job applications
- [Honeybadger](https://www.honeybadger.io/) for monitoring errors
- [React](https://react.dev/) for the frontend. Although, erb is used in some cases, such as Devise's views
- [Bootstrap](https://getbootstrap.com/) as CSS framework
- [Redux](https://react-redux.js.org/) for managing state in certain features. Even though it was not strictly necessary for such features, I thought it appropriate to add it
- [React-Router](https://reactrouter.com/) for managing navigation and UI updates within sections
- Internationalization for English and Spanish
- Custom error pages
- Github Actions for rubocop, erb linter and GitGuardian

# Live Application
[https://simplestresumes.com/](https://simplestresumes.com/)
