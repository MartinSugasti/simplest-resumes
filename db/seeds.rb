# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

password = ENV['GENERAL_PASSWORD']

# Admin user
admin = Admin.new(email: 'admin@simplestresumes.com', password: password, role: :super_admin)
admin.skip_confirmation!
admin.save

# Collaborators created from console
collaborator_1 = Admin.new(email: 'collaborator_1@simplestresumes.com', password: password, role: :collaborator)
collaborator_1.skip_confirmation!
collaborator_1.save

collaborator_2 = Admin.new(email: 'collaborator_2@simplestresumes.com', password: password, role: :collaborator)
collaborator_2.skip_confirmation!
collaborator_2.save

# Colaborators created from approved invitation requests
invitation_request_1 = InvitationRequest.create(email: 'collaborator_3@simplestresumes.com')
invitation_request_1.update(status: :approved)
collaborator_3 = Admin.invite!(email: invitation_request_1.email, password: password, role: :collaborator) do |collaborator|
  collaborator.invited_by = admin
  collaborator.skip_invitation = true
  collaborator.skip_confirmation!
end
collaborator_3.password = password
collaborator_3.accept_invitation!
collaborator_3.confirm

invitation_request_2 = InvitationRequest.create(email: 'collaborator_4@simplestresumes.com')
invitation_request_2.update(status: :approved)
collaborator_4 = Admin.invite!(email: invitation_request_2.email, password: password, role: :collaborator) do |collaborator|
  collaborator.invited_by = admin
  collaborator.skip_invitation = true
  collaborator.skip_confirmation!
end
collaborator_4.password = password
collaborator_4.accept_invitation!
collaborator_4.confirm

# Approved invitation requests
invitation_request_3 = InvitationRequest.create(email: 'collaborator_5@simplestresumes.com', status: :approved)
collaborator_5 = Admin.invite!(email: invitation_request_3.email, role: :collaborator) do |collaborator|
  collaborator.invited_by = admin
  collaborator.skip_invitation = true
  collaborator.skip_confirmation!
end

invitation_request_4 = InvitationRequest.create(email: 'collaborator_6@simplestresumes.com', status: :approved)
collaborator_6 = Admin.invite!(email: invitation_request_4.email, role: :collaborator) do |collaborator|
  collaborator.invited_by = admin
  collaborator.skip_invitation = true
  collaborator.skip_confirmation!
end

# Pending invitation requests
invitation_request_5 = InvitationRequest.create(email: 'collaborator_7@simplestresumes.com')
invitation_request_6 = InvitationRequest.create(email: 'collaborator_8@simplestresumes.com')

# Dismissed invitation requests
invitation_request_7 = InvitationRequest.create(email: 'collaborator_9@simplestresumes.com', status: :dismissed)
invitation_request_8 = InvitationRequest.create(email: 'collaborator_10@simplestresumes.com', status: :dismissed)

# Banned invitation requests
invitation_request_9 = InvitationRequest.create(email: 'collaborator_11@simplestresumes.com', status: :banned)
invitation_request_10 = InvitationRequest.create(email: 'collaborator_12@simplestresumes.com', status: :banned)

# Recruiters
recruiter_1 = Recruiter.new(email: 'recruiter_1@simplestresumes.com', password: password)
recruiter_1.skip_confirmation!
recruiter_1.save

recruiter_2 = Recruiter.new(email: 'recruiter_2@simplestresumes.com', password: password)
recruiter_2.skip_confirmation!
recruiter_2.save

recruiter_3 = Recruiter.new(email: 'recruiter_3@simplestresumes.com', password: password)
recruiter_3.skip_confirmation!
recruiter_3.save

# Candidates
candidate_1 = Candidate.new(email: 'candidate_1@simplestresumes.com', password: password)
candidate_1.skip_confirmation!
candidate_1.save

candidate_2 = Candidate.new(email: 'candidate_2@simplestresumes.com', password: password)
candidate_2.skip_confirmation!
candidate_2.save

candidate_3 = Candidate.new(email: 'candidate_3@simplestresumes.com', password: password)
candidate_3.skip_confirmation!
candidate_3.save

candidate_4 = Candidate.new(email: 'candidate_4@simplestresumes.com', password: password)
candidate_4.skip_confirmation!
candidate_4.save

candidate_5 = Candidate.new(email: 'candidate_5@simplestresumes.com', password: password)
candidate_5.skip_confirmation!
candidate_5.save

candidate_6 = Candidate.new(email: 'candidate_6@simplestresumes.com', password: password)
candidate_6.skip_confirmation!
candidate_6.save

candidate_7 = Candidate.new(email: 'candidate_7@simplestresumes.com', password: password)
candidate_7.skip_confirmation!
candidate_7.save

# Resumes
resume_1 = Resume.create(
  candidate_id: candidate_1.id,
  name: 'John Smith',
  email: candidate_1.email,
  mobile: '+1 786 451 7550',
  location: 'Miami, USA',
  about_me: 'I am a highly motivated and results-oriented professional with 5+ years of experience in the marketing and advertising industry. I have a proven track record of developing and executing successful marketing campaigns that have generated leads, increased brand awareness, and improved sales. I am passionate about using my skills and experience to help businesses grow and succeed.'
)

EducationItem.create(
  resume_id: resume_1.id,
  name: 'Marketing',
  institute: 'Univiresity of Florida',
  start_year: 2009,
  end_year: 2014
)

EducationItem.create(
  resume_id: resume_1.id,
  name: 'Brand Marketing',
  institute: 'Miami Marketing School',
  start_year: 2013,
  end_year: 2014
)

EducationItem.create(
  resume_id: resume_1.id,
  name: 'AI on Marketing',
  institute: 'Fort Laudardale Collegue',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_1,
  name: 'Marketing strategy',
  kind: :primary,
)

SkillItem.create(
  resume: resume_1,
  name: 'Lead generation',
  kind: :primary,
)

SkillItem.create(
  resume: resume_1,
  name: 'Sales growth',
  kind: :primary,
)

SkillItem.create(
  resume: resume_1,
  name: 'Social media marketing',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_1,
  name: 'Content marketing',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_1,
  name: 'Digital marketing',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_1,
  name: 'Email marketing',
  kind: :secondary,
)

ReferenceItem.create(
  resume: resume_1,
  name: 'John Smith',
  position: 'Manager, Marketing',
  company: 'Acme Corporation',
  mobile: '+1 555 5555555',
  kind: :personal
)

ReferenceItem.create(
  resume: resume_1,
  name: 'Jane Doe',
  position: 'Senior Software Engineer',
  company: 'Beta Technologies',
  mobile: '+1 555 5555556',
  kind: :job
)

ReferenceItem.create(
  resume: resume_1,
  name: 'Peter Jones',
  position: 'Account Manager',
  company: 'Gamma Solutions',
  mobile: '+1 555 5555557',
  kind: :job
)

WorkExperienceItem.create(
  resume: resume_1,
  position: 'Graphic Designer',
  company: 'Eta Communications',
  location: 'Houston, TX',
  start_month: 4,
  start_year: 2018,
  description: "Developed and implemented HR policies and procedures that ensured compliance with all applicable laws and regulations. During my time at Eta Communications, I was responsible for: Created high-quality content that was informative, engaging, and optimized for search engines. Provided excellent customer service, resolving issues quickly and efficiently. Developed and maintained web applications using Java, JavaScript, and HTML."
)

WorkExperienceItem.create(
  resume: resume_1,
  position: 'Account Manager',
  company: 'Epsilon Systems',
  location: 'Philadelphia, PA',
  start_month: 3,
  start_year: 2014,
  end_month: 3,
  end_year: 2018,
  description: "Managed and grew the company's social media presence, increasing engagement and brand awareness. During my time at Epsilon Systems, I was responsible for: Created visually appealing and effective designs for a variety of marketing materials. Managed and grew the company's social media presence, increasing engagement and brand awareness. Created high-quality content that was informative, engaging, and optimized for search engines."
)

WorkExperienceItem.create(
  resume: resume_1,
  position: 'Project Manager',
  company: 'Beta Technologies',
  location: 'San Diego, CA',
  start_month: 7,
  start_year: 2010,
  end_month: 2,
  end_year: 2014,
  description: "Provided excellent customer service, resolving issues quickly and efficiently. During my time at Beta Technologies, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Developed and implemented sales strategies that resulted in increased revenue. Created high-quality content that was informative, engaging, and optimized for search engines."
)

resume_2 = Resume.create(
  candidate_id: candidate_2.id,
  name: 'Xavier Guardiola',
  email: candidate_2.email,
  mobile: '+34 696 923 244',
  location: 'Barcelona, Spain',
  about_me: 'I am a software engineer with 3+ years of experience in developing and maintaining web applications. I am passionate about using my skills to create user-friendly and efficient software solutions. I am also a team player and I am always willing to go the extra mile to get the job done.'
)

EducationItem.create(
  resume_id: resume_2.id,
  name: 'Software Engineering',
  institute: 'Universidad de Barcelona',
  start_year: 2014,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_2.id,
  name: 'First Certificate in English',
  institute: 'Cambridge Assessment English',
  start_year: 2006,
  end_year: 2014
)

SkillItem.create(
  resume: resume_2,
  name: 'JavaScript',
  kind: :primary,
)

SkillItem.create(
  resume: resume_2,
  name: 'Python',
  kind: :primary,
)

SkillItem.create(
  resume: resume_2,
  name: 'SQL',
  kind: :primary,
)

SkillItem.create(
  resume: resume_2,
  name: 'HTML',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_2,
  name: 'CSS',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_2,
  name: 'Scrum',
  kind: :secondary,
)

ReferenceItem.create(
  resume: resume_2,
  name: 'Mary Brown',
  position: 'Graphic Designer',
  company: 'Delta Creative',
  mobile: '+1 555 5555558',
  kind: :personal
)

ReferenceItem.create(
  resume: resume_2,
  name: 'David Williams',
  position: 'Project Manager',
  company: 'Epsilon Systems',
  mobile: '+1 555 5555559',
  kind: :personal
)

ReferenceItem.create(
  resume: resume_2,
  name: 'Sarah Miller',
  position: 'Sales Representative',
  company: 'Zeta Corporation',
  mobile: '+1 555 5555560',
  kind: :job
)

WorkExperienceItem.create(
  resume: resume_2,
  position: 'Social Media Manager',
  company: 'Eta Communications',
  location: 'Philadelphia, PA',
  start_month: 3,
  start_year: 2021,
  description: "Managed and executed marketing campaigns that increased brand awareness and generated leads. During my time at Eta Communications, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Managed and executed projects from start to finish, ensuring they were completed on time and within budget. Created and executed marketing campaigns that supported the company's overall marketing strategy."
)

WorkExperienceItem.create(
  resume: resume_2,
  position: 'Social Media Manager',
  company: 'Theta Industries',
  location: 'Phoenix, AZ',
  start_month: 1,
  start_year: 2017,
  end_month: 2,
  end_year: 2021,
  description: "Provided excellent customer service, resolving issues quickly and efficiently. During my time at Theta Industries, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Provided excellent customer service, resolving issues quickly and efficiently. Managed and executed marketing campaigns that increased brand awareness and generated leads."
)

resume_3 = Resume.create(
  candidate_id: candidate_3.id,
  name: 'Angeline Ott',
  email: candidate_3.email,
  mobile: '+1 966 652 7150',
  location: 'New York, USA',
  about_me: 'I am a graphic designer with 5+ years of experience in creating visually appealing and effective designs. I am passionate about using my skills to communicate ideas and messages in a clear and concise way. I am also a creative thinker and I am always looking for new and innovative ways to solve design problems.'
)

EducationItem.create(
  resume_id: resume_3.id,
  name: 'Graphic Design',
  institute: 'New York Art University',
  start_year: 2010,
  end_year: 2015
)

EducationItem.create(
  resume_id: resume_3.id,
  name: 'Industrial Design',
  institute: 'School of Design, Berlin',
  start_year: 2017,
  end_year: 2019
)

SkillItem.create(
  resume: resume_3,
  name: 'Photoshop',
  kind: :primary,
)

SkillItem.create(
  resume: resume_3,
  name: 'InDesign',
  kind: :primary,
)

SkillItem.create(
  resume: resume_3,
  name: 'Branding',
  kind: :primary,
)

SkillItem.create(
  resume: resume_3,
  name: 'Marketing materials',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_3,
  name: 'User interface design',
  kind: :secondary,
)

ReferenceItem.create(
  resume: resume_3,
  name: 'Michael Davis',
  position: 'Customer Service Representative',
  company: 'Eta Communications',
  mobile: '+1 555 5555561',
  kind: :personal
)

ReferenceItem.create(
  resume: resume_3,
  name: 'Susan Johnson',
  position: 'Human Resources Manager',
  company: 'Theta Industries',
  mobile: '+1 555 5555562',
  kind: :job
)

ReferenceItem.create(
  resume: resume_3,
  name: 'Mark Wilson',
  position: 'Marketing Coordinator',
  company: 'Iota Consulting',
  mobile: '+1 555 5555563',
  kind: :job
)

WorkExperienceItem.create(
  resume: resume_3,
  position: 'Web Developer',
  company: 'Theta Industries',
  location: 'Dallas, TX',
  start_month: 2,
  start_year: 2019,
  end_month: 9,
  end_year: 2023,
  description: "Managed and grew the company's social media presence, increasing engagement and brand awareness. During my time at Theta Industries, I was responsible for: Managed and grew the company's social media presence, increasing engagement and brand awareness. Created high-quality content that was informative, engaging, and optimized for search engines. Created visually appealing and effective designs for a variety of marketing materials."
)

WorkExperienceItem.create(
  resume: resume_3,
  position: 'Human Resources Manager',
  company: 'Lambda Marketing',
  location: 'Phoenix, AZ',
  start_month: 5,
  start_year: 2014,
  end_month: 1,
  end_year: 2019,
  description: "Managed and executed marketing campaigns that increased brand awareness and generated leads. During my time at Lambda Marketing, I was responsible for: Created high-quality content that was informative, engaging, and optimized for search engines. Generated leads and closed deals, exceeding sales quotas consistently. Generated leads and closed deals, exceeding sales quotas consistently."
)

WorkExperienceItem.create(
  resume: resume_3,
  position: 'Customer Service Representative',
  company: 'Mu Consulting',
  location: 'Phoenix, AZ',
  start_month: 1,
  start_year: 2013,
  end_month: 4,
  end_year: 2014,
  description: "Created high-quality content that was informative, engaging, and optimized for search engines. During my time at Mu Consulting, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Generated leads and closed deals, exceeding sales quotas consistently. Created visually appealing and effective designs for a variety of marketing materials."
)

resume_4 = Resume.create(
  candidate_id: candidate_4.id,
  name: 'Mauricio Salmanton',
  email: candidate_4.email,
  mobile: '+598 98 236 009',
  location: 'Montevideo, Uruguay',
  about_me: 'Highly motivated and results-oriented marketing manager with 5+ years of experience in developing and executing successful marketing campaigns across various industries. Proven track record of increasing brand awareness, generating leads, and driving sales growth through a combination of strategic planning, creative execution, and data-driven analysis. Expertise in utilizing a range of marketing channels, including digital marketing, social media marketing, content marketing, email marketing, and public relations. Passionate about leveraging marketing to achieve business objectives and contribute to the overall success of an organization.'
)

EducationItem.create(
  resume_id: resume_4.id,
  name: 'Marketing',
  institute: 'Marketing School, UDE',
  start_year: 2022
)

SkillItem.create(
  resume: resume_4,
  name: 'Lead generation',
  kind: :primary,
)

SkillItem.create(
  resume: resume_4,
  name: 'Campaign development and execution',
  kind: :primary,
)

SkillItem.create(
  resume: resume_4,
  name: 'Brand awareness',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_4,
  name: 'Public relations',
  kind: :secondary,
)

ReferenceItem.create(
  resume: resume_4,
  name: 'Patricia Taylor',
  position: 'Web Developer',
  company: 'Kappa Solutions',
  mobile: '+1 555 5555564',
  kind: :personal
)

ReferenceItem.create(
  resume: resume_4,
  name: 'Robert Moore',
  position: 'Social Media Manager',
  company: 'Lambda Marketing',
  mobile: '+1 555 5555565',
  kind: :job
)

WorkExperienceItem.create(
  resume: resume_4,
  position: 'Social Media Manager',
  company: 'Mu Consulting',
  location: 'Jacksonville, FL',
  start_month: 2,
  start_year: 2023,
  description: "Created high-quality content that was informative, engaging, and optimized for search engines. During my time at Mu Consulting, I was responsible for: Provided excellent customer service, resolving issues quickly and efficiently. Managed and grew the company's social media presence, increasing engagement and brand awareness. Developed and maintained websites that were user-friendly and met the needs of the business."
)

WorkExperienceItem.create(
  resume: resume_4,
  position: 'Software Engineer',
  company: 'Kappa Solutions',
  location: 'San Jose, CA',
  start_month: 4,
  start_year: 2021,
  description: "Developed and maintained web applications using Java, JavaScript, and HTML. During my time at Kappa Solutions, I was responsible for: Managed and grew the company's social media presence, increasing engagement and brand awareness. Generated leads and closed deals, exceeding sales quotas consistently. Managed and executed projects from start to finish, ensuring they were completed on time and within budget."
)

resume_5 = Resume.create(
  candidate_id: candidate_5.id,
  name: 'Esteban Villamil',
  email: candidate_5.email,
  mobile: '+598 98 112 438',
  location: 'Colonia, Uruguay',
  about_me: 'Highly skilled and experienced software engineer with 3+ years of experience in developing and maintaining web applications. Passionate about creating user-friendly and efficient software solutions that meet the needs of businesses and users alike. Proven ability to work independently and as part of a team to deliver high-quality software on time and within budget. Expertise in a variety of programming languages and technologies, including JavaScript, HTML, CSS, Java, Python, and SQL.'
)

EducationItem.create(
  resume_id: resume_5.id,
  name: 'Software Analyst',
  institute: 'Facultad de Ingenieria, UDELAR',
  start_year: 2017,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_5.id,
  name: 'Software Engineering',
  institute: 'Facultad de Ingenieria, UDELAR',
  start_year: 2017
)

EducationItem.create(
  resume_id: resume_5.id,
  name: 'First Certificate in English',
  institute: 'Cambridge Assessment English',
  start_year: 2012,
  end_year: 2020
)

SkillItem.create(
  resume: resume_5,
  name: 'Ruby on Rails',
  kind: :primary,
)

SkillItem.create(
  resume: resume_5,
  name: 'React',
  kind: :primary,
)

SkillItem.create(
  resume: resume_5,
  name: 'Javascript',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_5,
  name: 'HTML',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_5,
  name: 'CSS',
  kind: :secondary,
)

SkillItem.create(
  resume: resume_5,
  name: 'Git',
  kind: :secondary,
)

ReferenceItem.create(
  resume: resume_5,
  name: 'Elizabeth Thomas',
  position: 'Content Writer',
  company: 'Mu Consulting',
  mobile: '+1 555 5555566',
  kind: :personal
)

ReferenceItem.create(
  resume: resume_5,
  name: 'Jennifer Houston',
  position: 'CEO',
  company: 'Mu Consulting',
  mobile: '+1 555 5555566',
  kind: :job
)

ReferenceItem.create(
  resume: resume_5,
  name: 'Jeremy James',
  position: 'Team Leader',
  company: 'Mu Consulting',
  mobile: '+1 555 5555566',
  kind: :job
)

WorkExperienceItem.create(
  resume: resume_5,
  position: 'Software Developer',
  company: 'Sugus',
  location: 'Montevideo, Uruguay',
  start_month: 2,
  start_year: 2022,
  description: "Since joining the team, I have continued to acquire knowledge in Ruby on Rails and at the same time I started to learn other technologies, including React, a frontend library, and Cucumber, a framework for behavior-driven development."
)

WorkExperienceItem.create(
  resume: resume_5,
  position: 'Software Developer',
  company: 'Eager Solutions',
  location: 'Montevideo, Uruguay',
  start_month: 10,
  start_year: 2019,
  end_month: 1,
  end_year: 2022,
  description: "Worked as a full-stack developer using Ruby on Rails framework gaining experience in, within others, authentication and authorization systems, background jobs, scheduled tasks, ajax requests, third-party APIs integration, internationalization, mailers, data visualization, etc. Alongside RoR, I also gained experience with other languages, libraries and development tools such as HTML, CSS, JS, bootstrap, git, GitHub, SQL and Heroku. During this time, I have dealt with a variety of clients, spanning from small local companies to large multinational corporations using Agile/Scrum development techniques, staying in touch with clients daily, and reaching mutual agreements on ideas and next steps."
)

WorkExperienceItem.create(
  resume: resume_5,
  position: 'Software Developer',
  company: 'BSE',
  location: 'Montevideo, Uruguay',
  start_month: 2,
  start_year: 2013,
  end_month: 9,
  end_year: 2019,
  description: "Planned preventive and corrective maintenance for the Coca-Cola products bottling company in Uruguay. Executed the maintenance management migration in SAP when the company ownership changed from The Coca-Cola Company to FEMSA. At this point, approximately 1,800 maintenance plans were redesigned."
)

# Job Positions
job_posting_1 = JobPosting.create(
  recruiter: recruiter_1,
  title: 'Software Engineer',
  company: 'Google',
  skills: 'Proficient in Java, Python, or C++',
  description: 'We are looking for a Software Engineer to join our team and help us develop innovative software solutions. You will be responsible for designing, developing, and testing software applications. You will also be responsible for collaborating with other engineers to ensure that our software meets the needs of our users.',
  published: true
)

JobPosting.create(
  recruiter: recruiter_1,
  title: 'Data Scientist',
  company: 'Facebook',
  skills: 'Experience with data mining and analysis tools',
  description: 'We are looking for a Data Scientist to join our team and help us make data-driven decisions. You will be responsible for collecting, cleaning, and analyzing data. You will also be responsible for developing and implementing machine learning models. You will work with other data scientists, engineers, and product managers to ensure that our data-driven insights are used to improve our products and services.',
  published: false
)

job_posting_2 = JobPosting.create(
  recruiter: recruiter_1,
  title: 'Product Manager',
  company: 'Amazon',
  skills: 'Experience with user experience (UX) and user interface (UI) design',
  description: 'We are looking for a Product Manager to join our team and help us develop and launch new products. You will be responsible for understanding the needs of our users and translating those needs into product requirements. You will also be responsible for working with engineers, designers, and marketers to bring our products to market.',
  published: true
)

JobPosting.create(
  recruiter: recruiter_2,
  title: 'Marketing Manager',
  company: 'Apple',
  skills: 'Strong understanding of marketing principles and strategies',
  description: 'We are looking for a Marketing Manager to join our team and help us promote our products and services. You will be responsible for developing and executing marketing campaigns. You will also be responsible for tracking the results of our campaigns and making adjustments as needed.',
  published: false
)

job_posting_3 = JobPosting.create(
  recruiter: recruiter_2,
  title: 'Sales Representative',
  company: 'Microsoft',
  skills: 'Experience with customer relationship management (CRM) software',
  description: 'We are looking for a Sales Representative to join our team and help us sell our products and services. You will be responsible for prospecting for new customers, qualifying leads, and closing deals. You will also be responsible for building relationships with our customers and providing them with excellent customer service.',
  published: true
)

job_posting_4 = JobPosting.create(
  recruiter: recruiter_2,
  title: 'Customer Service Representative',
  company: 'Salesforce',
  skills: 'Experience with customer service software',
  description: 'We are looking for a Customer Service Representative to join our team and help us provide our customers with excellent customer service. You will be responsible for answering customer questions, resolving customer issues, and providing customer support. You will also be responsible for building relationships with our customers and ensuring that they are satisfied with our products and services.',
  published: true
)

job_posting_5 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Human Resources Manager',
  company: 'Netflix',
  skills: 'Experience with recruiting, hiring, and onboarding employees',
  description: 'We are looking for a Human Resources Manager to join our team and help us manage our human resources functions. You will be responsible for recruiting, hiring, and onboarding new employees. You will also be responsible for developing and implementing human resources policies and procedures.',
  published: true
)

job_posting_6 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Finance Manager',
  company: 'PayPal',
  skills: 'Experience with financial reporting and analysis',
  description: 'We are looking for a Finance Manager to join our team and help us manage our financial functions. You will be responsible for preparing financial reports, analyzing financial data, and developing financial forecasts.',
  published: true
)

job_posting_7 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Front-End Develope',
  company: 'Acme Corporation',
  skills: 'Proficient in HTML, CSS, and JavaScript',
  description: 'Collaborate with designers and back-end developers to create user-centered web applications. Design and implement UI components using HTML, CSS, and JavaScript. Develop and maintain reusable code libraries and components. Ensure cross-browser compatibility of web applications. Stay up-to-date with the latest web development trends and technologies',
  published: true
)

job_posting_8 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Full-Stack Developer',
  company: 'Beta Technologies',
  skills: 'Python, PostgreSQL, AWS',
  description: 'Design, develop, and maintain web applications. Write clean, maintainable code. Collaborate with designers and product managers to understand user requirements. Implement unit tests and integration tests to ensure code quality. Deploy web applications to production environments. Monitor web applications for performance and stability',
  published: true
)

# Postulations
Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_4,
  status: :rejected
)

Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_7,
  status: :approved
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_1,
  status: :pending
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_2,
  status: :rejected
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_7,
  status: :pending
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_1,
  status: :pending
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_3,
  status: :pending
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_8,
  status: :approved
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_2,
  status: :rejected
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_7,
  status: :pending
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_3,
  status: :approved
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_8,
  status: :approved
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_1,
  status: :rejected
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_6,
  status: :approved
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_7,
  status: :pending
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_8,
  status: :approved
)