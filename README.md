<p align="center">
  <img src="https://github.com/MartinSugasti/simplest-resumes/blob/main/app/assets/images/logos/primary.png" />
</p>

This is a personal project I developed to learn and improve my skills in various technologies and products commonly used in web applications. Although I had already worked with most of these technologies and products, few of them I implemented from the very beginning or just had the experience of practicing with tutorials or very simple courses. That is why I set myself the goal of integrating all of them from scratch into a more realistic medium size application.

In other words, the goal of this project was to implement from scratch a web application, from configuring the host provider and domain to implement web apps specific features, in order to keep growing as a software developer.

# Description
A concise description of the application would be it allows recruiters to post jobs, candidates to create, share, and download their resumes, and admin users to manage various aspects of the application.

This is a list of key technologies and features:
- [DigitalOcean](https://www.digitalocean.com/) for hosting
- [Ruby on Rails](https://rubyonrails.org/) for the backend
- [Bootstrap](https://getbootstrap.com/) for style
- [React](https://react.dev/) for the frontend for most features
- [Redux](https://react-redux.js.org/) for managing state in certain features
- [React-Router](https://reactrouter.com/) for routing between different pages
- [Devise](https://github.com/heartcombo/devise) for authentication for candidates, recruiters, and admins
- [Devise Masquerade](https://github.com/oivoodoo/devise_masquerade) for admins to impersonate candidates and recruiters
- [Omniauth](https://github.com/omniauth/omniauth) for social login with Gmail, Twitter, and GitHub for candidates and recruiters
- [Pundit](https://github.com/varvet/pundit) for implementing authorization
- [Sidekiq](https://sidekiq.org/) and [Redis](https://redis.com/) for handling background jobs, such as sending SMS to candidates when their job applications are approved
- [Sendgrid](https://sendgrid.com/) as an SMTP provider and [Twilio](https://pages.twilio.com/) for sending SMS notifications
- Scheduled jobs using [Sidekiq-Scheduler](https://github.com/sidekiq-scheduler/sidekiq-scheduler) for scheduled tasks, such as sending reminder emails
- Active Storage with [Amazon S3](https://aws.amazon.com/) for storing images, such as profile pictures
- Internationalization for English and Spanish
- Custom error pages
- [Stripe](https://stripe.com/) integration for allowing candidates to subscribe for unlimited job applications


# Live Application
[https://simplestresumes.com/](https://simplestresumes.com/)
