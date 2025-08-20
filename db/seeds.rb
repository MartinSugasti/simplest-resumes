# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

password = ENV.fetch('GENERAL_PASSWORD', nil)

Candidate.skip_callback(:create, :after, :create_stripe_customer)

# ---------- Admin users ----------
# Super Admin user
admin = Admin.new(email: 'admin@simplestresumes.com', password: password, role: :super_admin)
admin.skip_confirmation!
admin.save

# Collaborator 1 created from console
collaborator_1 = Admin.new(email: 'collaborator_1@simplestresumes.com', password: password, role: :collaborator)
collaborator_1.skip_confirmation!
collaborator_1.save

# Collaborator 2 created from console
collaborator_2 = Admin.new(email: 'collaborator_2@simplestresumes.com', password: password, role: :collaborator)
collaborator_2.skip_confirmation!
collaborator_2.save

# Colaborator 3 created from approved invitation request, which was accepted
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

# Colaborator 4 created from approved invitation request, which was accepted
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

# Colaborator created from approved invitation request, which hasn't been accepted
invitation_request_3 = InvitationRequest.create(email: 'collaborator_5@simplestresumes.com', status: :approved)
Admin.invite!(email: invitation_request_3.email, role: :collaborator) do |collaborator|
  collaborator.invited_by = admin
  collaborator.skip_invitation = true
  collaborator.skip_confirmation!
end

# Colaborator created from approved invitation request, which hasn't been accepted
invitation_request_4 = InvitationRequest.create(email: 'collaborator_6@simplestresumes.com', status: :approved)
Admin.invite!(email: invitation_request_4.email, role: :collaborator) do |collaborator|
  collaborator.invited_by = admin
  collaborator.skip_invitation = true
  collaborator.skip_confirmation!
end

# Pending invitation requests
InvitationRequest.create(email: 'collaborator_7@simplestresumes.com')
InvitationRequest.create(email: 'collaborator_8@simplestresumes.com')

# Dismissed invitation requests
InvitationRequest.create(email: 'collaborator_9@simplestresumes.com', status: :dismissed)
InvitationRequest.create(email: 'collaborator_10@simplestresumes.com', status: :dismissed)

# Banned invitation requests
InvitationRequest.create(email: 'collaborator_11@simplestresumes.com', status: :banned)
InvitationRequest.create(email: 'collaborator_12@simplestresumes.com', status: :banned)

# ---------- Recruiters and their Job Postings ----------
# Recruiter 1
recruiter_1 = Recruiter.new(email: 'recruiter_1@simplestresumes.com', password: password)
recruiter_1.skip_confirmation!
recruiter_1.save

job_posting_1 = JobPosting.create(
  recruiter: recruiter_1,
  title: 'Software Engineer',
  company: 'Google',
  skills: 'Proficient in Java, Python, or C#',
  description: 'We are looking for a Software Engineer to join our team and help us develop innovative software solutions. You will be responsible for designing, developing, and testing software applications. You will also be responsible for collaborating with other engineers to ensure that our software meets the needs of our users.',
  published: true
)

job_posting_2 = JobPosting.create(
  recruiter: recruiter_1,
  title: 'Data Scientist',
  company: 'Facebook',
  skills: 'Experience with data mining and analysis tools',
  description: 'We are looking for a Data Scientist to join our team and help us make data-driven decisions. You will be responsible for collecting, cleaning, and analyzing data. You will also be responsible for developing and implementing machine learning models. You will work with other data scientists, engineers, and product managers to ensure that our data-driven insights are used to improve our products and services.',
  published: false
)

job_posting_3 = JobPosting.create(
  recruiter: recruiter_1,
  title: 'Product Manager',
  company: 'Amazon',
  skills: 'Experience with user experience (UX) and user interface (UI) design',
  description: 'We are looking for a Product Manager to join our team and help us develop and launch new products. You will be responsible for understanding the needs of our users and translating those needs into product requirements. You will also be responsible for working with engineers, designers, and marketers to bring our products to market.',
  published: false
)

# Recruiter 2
recruiter_2 = Recruiter.new(email: 'recruiter_2@simplestresumes.com', password: password)
recruiter_2.skip_confirmation!
recruiter_2.save

job_posting_4 = JobPosting.create(
  recruiter: recruiter_2,
  title: 'Marketing Manager',
  company: 'Apple',
  skills: 'Strong understanding of marketing principles and strategies',
  description: 'We are looking for a Marketing Manager to join our team and help us promote our products and services. You will be responsible for developing and executing marketing campaigns. You will also be responsible for tracking the results of our campaigns and making adjustments as needed.',
  published: true
)

job_posting_5 = JobPosting.create(
  recruiter: recruiter_2,
  title: 'Sales Representative',
  company: 'Microsoft',
  skills: 'Experience with customer relationship management (CRM) software',
  description: 'We are looking for a Sales Representative to join our team and help us sell our products and services. You will be responsible for prospecting for new customers, qualifying leads, and closing deals. You will also be responsible for building relationships with our customers and providing them with excellent customer service.',
  published: true
)

job_posting_6 = JobPosting.create(
  recruiter: recruiter_2,
  title: 'Customer Service Representative',
  company: 'PepsiCo',
  skills: 'Experience with customer service software',
  description: 'We are looking for a Customer Service Representative to join our team and help us provide our customers with excellent customer service. You will be responsible for answering customer questions, resolving customer issues, and providing customer support. You will also be responsible for building relationships with our customers and ensuring that they are satisfied with our products and services.',
  published: true
)

# Recruiter 3
recruiter_3 = Recruiter.new(email: 'recruiter_3@simplestresumes.com', password: password)
recruiter_3.skip_confirmation!
recruiter_3.save

job_posting_7 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Human Resources Manager',
  company: 'PepsiCo',
  skills: 'Experience with recruiting, hiring, and onboarding employees',
  description: 'We are looking for a Human Resources Manager to join our team and help us manage our human resources functions. You will be responsible for recruiting, hiring, and onboarding new employees. You will also be responsible for developing and implementing human resources policies and procedures.',
  published: true
)

job_posting_8 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Finance Manager',
  company: 'PepsiCo',
  skills: 'Experience with financial reporting and analysis',
  description: 'We are looking for a Finance Manager to join our team and help us manage our financial functions. You will be responsible for preparing financial reports, analyzing financial data, and developing financial forecasts.',
  published: true
)

job_posting_9 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Front-End Develope',
  company: 'PepsiCo',
  skills: 'Proficient in HTML, CSS, and JavaScript',
  description: 'Collaborate with designers and back-end developers to create user-centered web applications. Design and implement UI components using HTML, CSS, and JavaScript. Develop and maintain reusable code libraries and components. Ensure cross-browser compatibility of web applications. Stay up-to-date with the latest web development trends and technologies',
  published: true
)

job_posting_10 = JobPosting.create(
  recruiter: recruiter_3,
  title: 'Full-Stack Developer',
  company: 'PepsiCo',
  skills: 'Python, PostgreSQL, AWS',
  description: 'Design, develop, and maintain web applications. Write clean, maintainable code. Collaborate with designers and product managers to understand user requirements. Implement unit tests and integration tests to ensure code quality. Deploy web applications to production environments. Monitor web applications for performance and stability',
  published: true
)

# Recruiter 4
recruiter_4 = Recruiter.new(email: 'recruiter_4@simplestresumes.com', password: password)
recruiter_4.skip_confirmation!
recruiter_4.save

job_posting_11 = JobPosting.create(
  recruiter: recruiter_4,
  title: 'DevOps Engineer',
  company: 'Google',
  skills: 'Docker, Kubernetes, AWS, CI/CD',
  description: 'We are seeking a skilled DevOps Engineer to join our dynamic team and help us build and maintain robust infrastructure solutions. You will be responsible for automating deployments, monitoring systems, and ensuring high availability across our cloud-based applications. Your role will involve designing and implementing CI/CD pipelines, managing container orchestration with Kubernetes, and optimizing our AWS infrastructure for cost and performance. You will collaborate closely with development teams to streamline the software delivery process and implement best practices for infrastructure as code. Additionally, you will be involved in troubleshooting production issues, implementing monitoring and alerting solutions, and contributing to our disaster recovery planning. This position requires strong problem-solving skills, experience with cloud platforms, and a passion for automation and efficiency.',
  published: true
)

job_posting_12 = JobPosting.create(
  recruiter: recruiter_4,
  title: 'QA Engineer',
  company: 'Google',
  skills: 'Selenium, JUnit, TestNG, API testing',
  description: 'Join our dedicated QA team to ensure the highest quality standards for our software products. You will be responsible for designing and executing comprehensive test plans, automating testing processes, and working closely with developers to identify and resolve issues early in the development cycle. Your role will involve creating and maintaining automated test suites using Selenium, JUnit, and TestNG, as well as conducting thorough API testing to validate backend functionality. You will participate in agile development processes, attend sprint planning meetings, and contribute to the continuous improvement of our testing methodologies. Additionally, you will be involved in performance testing, security testing, and user acceptance testing to ensure our products meet both functional and non-functional requirements. This position offers opportunities for growth in test automation and quality assurance leadership.',
  published: true
)

job_posting_13 = JobPosting.create(
  recruiter: recruiter_4,
  title: 'UI/UX Designer',
  company: 'Google',
  skills: 'Figma, Sketch, Adobe Creative Suite',
  description: 'Create beautiful and intuitive user interfaces that delight our customers and drive business success. You will work closely with product managers and developers to design user experiences that are both aesthetically pleasing and highly functional. Your role will involve conducting user research, creating wireframes and prototypes, and developing comprehensive design systems that ensure consistency across our product portfolio. You will use tools like Figma, Sketch, and Adobe Creative Suite to create high-fidelity designs and collaborate with development teams to ensure accurate implementation. Additionally, you will participate in user testing sessions, gather feedback, and iterate on designs based on user insights and business requirements. This position requires a strong understanding of user-centered design principles, excellent communication skills, and the ability to balance creative vision with practical implementation constraints.',
  published: false
)

job_posting_14 = JobPosting.create(
  recruiter: recruiter_4,
  title: 'Business Analyst',
  company: 'Google',
  skills: 'SQL, Excel, Tableau, Business process modeling',
  description: 'Bridge the gap between business needs and technical solutions by analyzing requirements and creating comprehensive specifications. You will work closely with stakeholders across the organization to understand business objectives, gather requirements, and translate them into actionable technical specifications. Your role will involve conducting detailed business process analysis, creating process flow diagrams, and identifying opportunities for improvement and optimization. You will use SQL, Excel, and Tableau to analyze data and create insightful reports that support business decision-making. Additionally, you will collaborate with development teams to ensure successful project delivery, participate in user acceptance testing, and provide ongoing support for implemented solutions. This position requires strong analytical thinking, excellent communication skills, and the ability to work effectively with both technical and non-technical stakeholders.',
  published: true
)

job_posting_15 = JobPosting.create(
  recruiter: recruiter_4,
  title: 'Content Writer',
  company: 'Google',
  skills: 'SEO, Copywriting, Content strategy, CMS',
  description: 'Create engaging content that drives traffic, increases conversions, and strengthens our brand presence across all digital channels. You will be responsible for writing compelling blog posts, website copy, marketing materials, and social media content that resonates with our target audience. Your role will involve developing content strategies, conducting keyword research for SEO optimization, and creating content calendars that align with our marketing objectives. You will work closely with our marketing team to ensure content consistency and brand alignment, while also collaborating with designers to create visually appealing content pieces. Additionally, you will manage our content management system, track content performance metrics, and continuously optimize content based on analytics and user feedback. This position requires excellent writing skills, creativity, and a deep understanding of digital marketing principles.',
  published: true
)

# Recruiter 5
recruiter_5 = Recruiter.new(email: 'recruiter_5@simplestresumes.com', password: password)
recruiter_5.skip_confirmation!
recruiter_5.save

job_posting_16 = JobPosting.create(
  recruiter: recruiter_5,
  title: 'Mobile Developer',
  company: 'Amazon',
  skills: 'React Native, iOS, Android, JavaScript',
  description: 'Build cross-platform mobile applications that provide exceptional user experiences across iOS and Android platforms. You will work closely with our design and backend teams to create amazing mobile experiences that meet both user needs and business objectives. Your role will involve developing native and cross-platform applications using React Native, implementing responsive designs, and ensuring optimal performance across different devices and screen sizes. You will collaborate with UX designers to implement intuitive user interfaces, integrate with backend APIs, and implement features like push notifications, offline functionality, and social media integration. Additionally, you will participate in code reviews, write unit tests, and contribute to our mobile development best practices and standards. This position offers opportunities to work with cutting-edge mobile technologies and contribute to the growth of our mobile product portfolio.',
  published: true
)

job_posting_17 = JobPosting.create(
  recruiter: recruiter_5,
  title: 'Data Engineer',
  company: 'Amazon',
  skills: 'Python, Apache Spark, Hadoop, SQL',
  description: 'Build and maintain robust data pipelines that enable data-driven decision making across our organization. You will work with large datasets and help create scalable data infrastructure that supports our analytics and machine learning initiatives. Your role will involve designing and implementing ETL processes, optimizing data warehouse performance, and ensuring data quality and reliability. You will use technologies like Python, Apache Spark, and Hadoop to process large volumes of data efficiently, while also working with SQL databases to create optimized queries and data models. Additionally, you will collaborate with data scientists and analysts to understand their data requirements, implement data governance policies, and contribute to our data architecture strategy. This position requires strong programming skills, experience with big data technologies, and a passion for solving complex data challenges.',
  published: true
)

job_posting_18 = JobPosting.create(
  recruiter: recruiter_5,
  title: 'Security Engineer',
  company: 'Amazon',
  skills: 'Penetration testing, Security tools, Network security',
  description: 'Protect our systems and data from evolving cyber threats by implementing comprehensive security measures and conducting thorough security assessments. You will be responsible for identifying vulnerabilities in our infrastructure, applications, and networks, and developing strategies to mitigate security risks. Your role will involve conducting penetration testing, implementing security monitoring tools, and responding to security incidents in a timely and effective manner. You will work closely with development teams to integrate security best practices into the software development lifecycle, conduct security code reviews, and provide security training to staff members. Additionally, you will stay current with emerging security threats and technologies, participate in security audits and compliance assessments, and contribute to our overall security strategy and policies. This position requires strong technical skills, analytical thinking, and a commitment to maintaining the highest security standards.',
  published: false
)

job_posting_19 = JobPosting.create(
  recruiter: recruiter_5,
  title: 'Product Owner',
  company: 'Amazon',
  skills: 'Agile, Scrum, User stories, Product strategy',
  description: 'Lead product development from concept to launch by working closely with stakeholders and development teams to deliver value to our customers. You will be responsible for understanding market needs, defining product vision and strategy, and translating business requirements into actionable user stories and product specifications. Your role will involve prioritizing product backlog items, collaborating with UX designers to create user-centered solutions, and working with development teams to ensure successful product delivery. You will participate in sprint planning, review completed work, and gather feedback from users and stakeholders to continuously improve our products. Additionally, you will analyze market trends, competitive landscape, and user feedback to identify opportunities for product enhancement and innovation. This position requires strong leadership skills, business acumen, and the ability to balance multiple stakeholder needs while driving product success.',
  published: true
)

job_posting_20 = JobPosting.create(
  recruiter: recruiter_5,
  title: 'Technical Writer',
  company: 'Amazon',
  skills: 'Technical writing, API documentation, User guides',
  description: 'Create clear and comprehensive technical documentation that helps users and developers understand and effectively use our products and services. You will be responsible for writing user manuals, API documentation, technical specifications, and other technical content that meets the needs of different audiences. Your role will involve working closely with development teams to understand product functionality, interviewing subject matter experts to gather technical information, and organizing complex technical concepts into clear, accessible documentation. You will use various tools and platforms to create and maintain documentation, ensure consistency in style and terminology, and continuously update content based on product changes and user feedback. Additionally, you will contribute to our documentation standards and processes, participate in content reviews, and help improve the overall user experience through better documentation. This position requires excellent writing skills, technical aptitude, and the ability to communicate complex information clearly.',
  published: true
)

# Recruiter 6
recruiter_6 = Recruiter.new(email: 'recruiter_6@simplestresumes.com', password: password)
recruiter_6.skip_confirmation!
recruiter_6.save

job_posting_21 = JobPosting.create(
  recruiter: recruiter_6,
  title: 'Cloud Architect',
  company: 'Nike',
  skills: 'AWS, Azure, GCP, Infrastructure as Code',
  description: 'Design and implement scalable, secure, and cost-effective cloud solutions that support our business growth and technological innovation. You will be responsible for architecting cloud infrastructure that meets performance, security, and compliance requirements while optimizing costs and resource utilization. Your role will involve working with multiple cloud platforms including AWS, Azure, and GCP, implementing infrastructure as code using tools like Terraform and CloudFormation, and designing multi-cloud and hybrid cloud solutions. You will collaborate with development teams to ensure applications are designed for cloud deployment, implement security best practices and compliance controls, and establish monitoring and alerting systems for optimal performance. Additionally, you will provide technical leadership, mentor team members, and stay current with emerging cloud technologies and best practices to drive continuous improvement in our cloud architecture.',
  published: true
)

job_posting_22 = JobPosting.create(
  recruiter: recruiter_6,
  title: 'Machine Learning Engineer',
  company: 'Nike',
  skills: 'Python, TensorFlow, PyTorch, ML algorithms',
  description: 'Build and deploy machine learning models that drive business value and provide actionable insights from our data. You will work closely with data scientists to develop, test, and optimize machine learning algorithms, and implement scalable ML pipelines that can process large volumes of data efficiently. Your role will involve selecting appropriate ML algorithms for different use cases, implementing models using frameworks like TensorFlow and PyTorch, and ensuring models are production-ready with proper monitoring and versioning. You will collaborate with data engineers to design data pipelines that support ML workflows, work with DevOps teams to deploy models in production environments, and implement A/B testing frameworks to measure model performance. Additionally, you will stay current with ML research and industry trends, contribute to our ML platform development, and help establish best practices for machine learning engineering across the organization.',
  published: true
)

job_posting_23 = JobPosting.create(
  recruiter: recruiter_6,
  title: 'Scrum Master',
  company: 'Nike',
  skills: 'Scrum, Kanban, Team facilitation, Agile coaching',
  description: 'Guide our development teams through agile processes and help them deliver high-quality software efficiently and predictably. You will be responsible for facilitating Scrum ceremonies, removing impediments that block team progress, and coaching team members on agile principles and practices. Your role will involve working with product owners to maintain healthy product backlogs, helping teams estimate work and plan sprints effectively, and monitoring team velocity and performance metrics to identify areas for improvement. You will serve as a servant leader, supporting teams in their self-organization and continuous improvement efforts, while also working with stakeholders to ensure clear communication and alignment on project goals. Additionally, you will help establish and maintain agile practices across the organization, provide training on agile methodologies, and contribute to our overall project management strategy and standards.',
  published: true
)

job_posting_24 = JobPosting.create(
  recruiter: recruiter_6,
  title: 'Database Administrator',
  company: 'Nike',
  skills: 'PostgreSQL, MySQL, Database optimization, Backup strategies',
  description: 'Manage and optimize our database systems to ensure optimal performance, reliability, and data integrity across all applications and services. You will be responsible for database design, performance tuning, capacity planning, and implementing backup and recovery strategies that protect our critical data assets. Your role will involve monitoring database performance metrics, identifying and resolving performance bottlenecks, and implementing database security measures to protect sensitive information. You will work with development teams to optimize database queries, design efficient database schemas, and implement database migration strategies for application updates. Additionally, you will establish database maintenance procedures, create disaster recovery plans, and stay current with database technologies and best practices to continuously improve our database infrastructure and operations.',
  published: true
)

job_posting_25 = JobPosting.create(
  recruiter: recruiter_6,
  title: 'Network Engineer',
  company: 'Nike',
  skills: 'Cisco, Network protocols, Network security, Troubleshooting',
  description: 'Design and maintain our network infrastructure to ensure reliable connectivity, optimal performance, and robust security for all users and systems. You will be responsible for planning and implementing network architectures, configuring network devices, and monitoring network performance to identify and resolve issues proactively. Your role will involve working with Cisco equipment and other network technologies, implementing network security measures including firewalls and intrusion detection systems, and troubleshooting complex network problems that affect business operations. You will collaborate with IT teams to ensure network infrastructure supports business requirements, implement network automation and monitoring tools, and contribute to network capacity planning and expansion strategies. Additionally, you will maintain network documentation, establish network policies and procedures, and stay current with emerging networking technologies to drive continuous improvement in our network infrastructure.',
  published: true
)

# Recruiter 7
recruiter_7 = Recruiter.new(email: 'recruiter_7@simplestresumes.com', password: password)
recruiter_7.skip_confirmation!
recruiter_7.save

job_posting_26 = JobPosting.create(
  recruiter: recruiter_7,
  title: 'Frontend Developer',
  company: 'Facebook',
  skills: 'React, Vue.js, TypeScript, CSS',
  description: 'Build modern, responsive web applications using cutting-edge frontend technologies that provide exceptional user experiences across all devices and browsers. You will be responsible for developing user interfaces that are both visually appealing and highly functional, implementing responsive designs that work seamlessly on desktop, tablet, and mobile devices. Your role will involve working with modern JavaScript frameworks like React and Vue.js, using TypeScript to write type-safe code, and implementing CSS frameworks and preprocessors to create maintainable and scalable styles. You will collaborate with UX designers to implement pixel-perfect designs, work with backend developers to integrate APIs, and participate in code reviews to ensure code quality and consistency. Additionally, you will stay current with frontend development trends, contribute to our frontend architecture decisions, and help establish best practices for frontend development across our teams.',
  published: true
)

job_posting_27 = JobPosting.create(
  recruiter: recruiter_7,
  title: 'Backend Developer',
  company: 'Facebook',
  skills: 'Node.js, Python, Java, Microservices',
  description: 'Develop robust, scalable backend services and APIs that power our applications and provide reliable data processing and business logic implementation. You will be responsible for designing and implementing server-side applications, creating RESTful APIs, and ensuring high performance and reliability of our backend systems. Your role will involve working with multiple programming languages including Node.js, Python, and Java, implementing microservices architecture patterns, and designing database schemas and data models that support business requirements. You will collaborate with frontend developers to ensure seamless API integration, work with DevOps teams to implement deployment and monitoring solutions, and participate in system design discussions to optimize performance and scalability. Additionally, you will write comprehensive tests, maintain code quality standards, and contribute to our backend architecture decisions and technology roadmap.',
  published: true
)

job_posting_28 = JobPosting.create(
  recruiter: recruiter_7,
  title: 'System Administrator',
  company: 'Facebook',
  skills: 'Linux, Windows Server, Shell scripting, Monitoring',
  description: 'Manage our server infrastructure and ensure system reliability, security, and optimal performance across all environments. You will be responsible for installing, configuring, and maintaining servers running Linux and Windows Server operating systems, implementing monitoring and alerting solutions, and responding to system issues and outages in a timely manner. Your role will involve writing shell scripts to automate routine tasks, managing user accounts and permissions, implementing backup and recovery procedures, and ensuring systems comply with security policies and best practices. You will work with development teams to deploy applications, collaborate with network engineers on infrastructure projects, and contribute to capacity planning and system expansion initiatives. Additionally, you will maintain system documentation, establish operational procedures, and stay current with system administration technologies and methodologies to drive continuous improvement in our infrastructure operations.',
  published: true
)

job_posting_29 = JobPosting.create(
  recruiter: recruiter_7,
  title: 'UX Researcher',
  company: 'Facebook',
  skills: 'User interviews, Usability testing, Personas, Journey mapping',
  description: 'Understand user needs, behaviors, and motivations through comprehensive research to inform product design decisions and improve user experience across our product portfolio. You will be responsible for planning and conducting user research studies, including user interviews, usability testing, surveys, and ethnographic research to gather insights about user needs and pain points. Your role will involve creating user personas, journey maps, and other research artifacts that help teams understand and empathize with users, analyzing research data to identify patterns and opportunities, and presenting findings to stakeholders to influence product decisions. You will collaborate with designers, product managers, and developers to ensure research insights are incorporated into product development, establish research methodologies and best practices, and contribute to our overall user experience strategy. Additionally, you will stay current with UX research methods and tools to continuously improve our research capabilities.',
  published: true
)

job_posting_30 = JobPosting.create(
  recruiter: recruiter_7,
  title: 'Digital Marketing Specialist',
  company: 'Facebook',
  skills: 'Google Ads, Facebook Ads, SEO, Analytics',
  description: 'Drive digital marketing campaigns and increase our online presence through strategic planning, execution, and optimization of various digital marketing channels. You will be responsible for managing paid advertising campaigns on platforms like Google Ads and Facebook Ads, implementing SEO strategies to improve organic search visibility, and analyzing marketing performance data to optimize campaigns and drive better results. Your role will involve creating and managing content marketing initiatives, developing email marketing campaigns, and implementing marketing automation strategies that nurture leads and drive conversions. You will work closely with content creators, designers, and sales teams to ensure marketing efforts align with business objectives, track and report on key marketing metrics, and stay current with digital marketing trends and best practices. Additionally, you will contribute to our overall marketing strategy, help establish marketing processes and standards, and continuously optimize our digital marketing efforts for maximum ROI.',
  published: true
)

# Recruiter 8
recruiter_8 = Recruiter.new(email: 'recruiter_8@simplestresumes.com', password: password)
recruiter_8.skip_confirmation!
recruiter_8.save

job_posting_31 = JobPosting.create(
  recruiter: recruiter_8,
  title: 'Game Developer',
  company: 'General Motors',
  skills: 'Unity, C#, Game design, 3D modeling',
  description: 'Create engaging and immersive video games that captivate players and provide memorable gaming experiences across multiple platforms. You will be responsible for developing game mechanics, implementing gameplay features, and creating interactive elements that engage players and drive user retention. Your role will involve working with Unity game engine and C# programming language to build game systems, collaborating with artists and designers to implement visual elements and game assets, and optimizing game performance for smooth gameplay across different devices. You will participate in game design discussions, contribute to gameplay mechanics development, and work with quality assurance teams to identify and resolve bugs and performance issues. Additionally, you will stay current with game development trends and technologies, contribute to our game development processes and standards, and help establish best practices for creating high-quality, engaging games that meet player expectations and business objectives.',
  published: true
)

job_posting_32 = JobPosting.create(
  recruiter: recruiter_8,
  title: 'Blockchain Developer',
  company: 'General Motors',
  skills: 'Solidity, Ethereum, Smart contracts, Web3',
  description: 'Build decentralized applications and smart contracts using cutting-edge blockchain technology to create innovative solutions that leverage the power of distributed ledgers and cryptocurrency platforms. You will be responsible for developing smart contracts using Solidity programming language, implementing blockchain-based applications on Ethereum and other blockchain platforms, and creating Web3 interfaces that enable users to interact with blockchain networks seamlessly. Your role will involve designing and implementing decentralized applications (dApps), ensuring smart contract security and best practices, and optimizing blockchain transactions for cost and performance. You will collaborate with product teams to understand business requirements, work with security experts to audit smart contracts, and contribute to our blockchain strategy and technology roadmap. Additionally, you will stay current with blockchain developments, participate in blockchain communities and conferences, and help establish our position as a leader in blockchain technology innovation.',
  published: true
)

job_posting_33 = JobPosting.create(
  recruiter: recruiter_8,
  title: 'AI Engineer',
  company: 'General Motors',
  skills: 'Python, Deep learning, NLP, Computer vision',
  description: 'Develop artificial intelligence solutions that solve complex business problems and provide intelligent automation across our product portfolio. You will be responsible for implementing machine learning models, developing natural language processing systems, and creating computer vision applications that can understand and interpret visual data. Your role will involve working with deep learning frameworks, implementing AI algorithms for various use cases, and optimizing AI models for production deployment and real-time performance. You will collaborate with data scientists to understand business requirements, work with engineering teams to integrate AI solutions into existing systems, and contribute to our AI strategy and technology roadmap. Additionally, you will stay current with AI research and developments, participate in AI communities and conferences, and help establish our position as a leader in artificial intelligence innovation and implementation.',
  published: true
)

job_posting_34 = JobPosting.create(
  recruiter: recruiter_8,
  title: 'IT Support Specialist',
  company: 'General Motors',
  skills: 'Help desk, Troubleshooting, Customer service, Hardware support',
  description: 'Provide comprehensive technical support to our team members and ensure smooth operation of all IT systems and equipment across the organization. You will be responsible for responding to help desk tickets, troubleshooting hardware and software issues, and providing timely solutions that minimize downtime and maintain productivity. Your role will involve supporting various operating systems, applications, and hardware devices, managing user accounts and permissions, and implementing IT policies and procedures that ensure security and compliance. You will work closely with other IT teams to escalate complex issues, participate in IT projects and system implementations, and contribute to our overall IT strategy and service delivery. Additionally, you will maintain IT documentation, provide training to users on IT systems and best practices, and continuously improve our IT support processes and customer service standards.',
  published: true
)

job_posting_35 = JobPosting.create(
  recruiter: recruiter_8,
  title: 'E-commerce Manager',
  company: 'General Motors',
  skills: 'Shopify, WooCommerce, Inventory management, Customer service',
  description: 'Manage our online store operations and drive sales growth through strategic e-commerce management, customer experience optimization, and data-driven decision making. You will be responsible for overseeing all aspects of our e-commerce platform, including product listings, inventory management, order processing, and customer service operations. Your role will involve optimizing the online shopping experience, implementing conversion rate optimization strategies, managing product catalogs and pricing, and analyzing e-commerce metrics to identify opportunities for improvement and growth. You will work closely with marketing teams to implement promotional campaigns, collaborate with customer service teams to resolve issues, and contribute to our overall e-commerce strategy and business objectives. Additionally, you will stay current with e-commerce trends and technologies, implement best practices for online retail, and help establish our position as a leading e-commerce destination in our market.',
  published: true
)

# Recruiter 9
recruiter_9 = Recruiter.new(email: 'recruiter_9@simplestresumes.com', password: password)
recruiter_9.skip_confirmation!
recruiter_9.save

job_posting_36 = JobPosting.create(
  recruiter: recruiter_9,
  title: 'Video Editor',
  company: 'Microsoft',
  skills: 'Adobe Premiere, After Effects, Motion graphics, Color grading',
  description: 'Create compelling video content that engages audiences, tells compelling stories, and drives business objectives across all digital platforms and marketing channels. You will be responsible for editing raw footage into polished, professional videos, adding visual effects and motion graphics, and ensuring consistent quality and brand alignment across all video content. Your role will involve working with Adobe Creative Suite tools including Premiere Pro and After Effects, implementing color grading and correction techniques, and creating motion graphics and animations that enhance video storytelling. You will collaborate with marketing teams to understand content objectives, work with creative directors to ensure brand consistency, and contribute to our overall video content strategy and production standards. Additionally, you will stay current with video editing trends and technologies, optimize videos for different platforms and devices, and help establish our position as a leader in video content creation and storytelling.',
  published: true
)

job_posting_37 = JobPosting.create(
  recruiter: recruiter_9,
  title: 'Social Media Manager',
  company: 'Microsoft',
  skills: 'Content creation, Community management, Analytics, Brand voice',
  description: 'Manage our social media presence across all platforms and create engaging content that builds brand awareness, drives engagement, and grows our online community. You will be responsible for developing and executing social media strategies, creating compelling content for various platforms, and managing day-to-day social media operations including posting, monitoring, and community engagement. Your role will involve analyzing social media performance metrics, identifying trends and opportunities, and optimizing content strategies based on data insights and audience feedback. You will work closely with marketing teams to align social media efforts with overall marketing objectives, collaborate with content creators to develop engaging posts, and contribute to our brand voice and messaging strategy. Additionally, you will stay current with social media trends and platform updates, implement best practices for community management, and help establish our position as a leading brand in social media engagement and community building.',
  published: true
)

job_posting_38 = JobPosting.create(
  recruiter: recruiter_9,
  title: 'Event Coordinator',
  company: 'Microsoft',
  skills: 'Event planning, Vendor management, Budget management, Logistics',
  description: 'Plan and execute successful events that create memorable experiences for attendees and achieve business objectives while managing all aspects of event logistics and coordination. You will be responsible for planning event concepts and themes, coordinating with vendors and suppliers, managing event budgets and timelines, and ensuring smooth execution of all event activities. Your role will involve selecting and managing event venues, coordinating with catering and entertainment providers, managing event registration and attendee communications, and implementing event marketing strategies to drive attendance and engagement. You will work closely with marketing teams to align events with business objectives, collaborate with various departments to ensure successful event delivery, and contribute to our overall event strategy and standards. Additionally, you will evaluate event success, gather attendee feedback, and continuously improve our event planning and execution processes.',
  published: true
)

job_posting_39 = JobPosting.create(
  recruiter: recruiter_9,
  title: 'Customer Success Manager',
  company: 'Microsoft',
  skills: 'Customer onboarding, Relationship management, Product training, Upselling',
  description: 'Ensure customer satisfaction and retention by building strong relationships, providing exceptional support, and helping customers achieve success with our products and services. You will be responsible for managing customer onboarding processes, conducting product training sessions, and maintaining regular communication with customers to understand their needs and challenges. Your role will involve monitoring customer health metrics, identifying at-risk accounts, and implementing strategies to improve customer satisfaction and reduce churn. You will work closely with sales teams to identify upselling and cross-selling opportunities, collaborate with product teams to communicate customer feedback and feature requests, and contribute to our overall customer success strategy and processes. Additionally, you will develop customer success programs and initiatives, establish best practices for customer relationship management, and help establish our reputation for exceptional customer service and support.',
  published: true
)

job_posting_40 = JobPosting.create(
  recruiter: recruiter_9,
  title: 'Legal Assistant',
  company: 'Microsoft',
  skills: 'Legal research, Document preparation, Case management, Client communication',
  description: 'Support our legal team with comprehensive research, document preparation, and case management to ensure efficient legal operations and excellent client service. You will be responsible for conducting legal research on various topics, preparing legal documents and correspondence, and managing case files and documentation to support attorneys in their work. Your role will involve communicating with clients to gather information and provide updates, coordinating with court personnel and other legal professionals, and maintaining organized case management systems that ensure timely and accurate legal service delivery. You will work closely with attorneys to understand case requirements, collaborate with administrative teams to ensure smooth operations, and contribute to our overall legal service standards and processes. Additionally, you will stay current with legal procedures and requirements, implement best practices for legal document management, and help maintain our reputation for professional and efficient legal services.',
  published: true
)

# Recruiter 10
recruiter_10 = Recruiter.new(email: 'recruiter_10@simplestresumes.com', password: password)
recruiter_10.skip_confirmation!
recruiter_10.save

job_posting_41 = JobPosting.create(
  recruiter: recruiter_10,
  title: 'Financial Analyst',
  company: 'The Home Depot',
  skills: 'Financial modeling, Excel, Data analysis, Reporting',
  description: 'Analyze financial data and provide insights that support strategic decision-making and drive business growth across all aspects of our organization. You will be responsible for creating comprehensive financial models, analyzing financial performance metrics, and preparing detailed reports that help stakeholders understand business performance and make informed decisions. Your role will involve working with large datasets in Excel and other financial software, creating forecasting models and budgets, and analyzing trends to identify opportunities for improvement and growth. You will collaborate with various departments to understand business drivers, work with senior management to develop financial strategies, and contribute to our overall financial planning and analysis processes. Additionally, you will stay current with financial analysis best practices, implement new analytical tools and methodologies, and help establish our position as a data-driven organization that makes sound financial decisions.',
  published: true
)

job_posting_42 = JobPosting.create(
  recruiter: recruiter_10,
  title: 'Operations Manager',
  company: 'The Home Depot',
  skills: 'Process improvement, Team leadership, Project management, KPI tracking',
  description: 'Optimize our business operations and lead teams to improve efficiency, productivity, and overall business performance across all operational areas. You will be responsible for analyzing current business processes, identifying inefficiencies and bottlenecks, and implementing improvements that drive operational excellence and cost savings. Your role will involve leading cross-functional teams, managing operational projects, and establishing key performance indicators (KPIs) to measure and track operational performance. You will work closely with department heads to understand operational challenges, collaborate with IT teams to implement process automation solutions, and contribute to our overall operational strategy and continuous improvement initiatives. Additionally, you will develop operational policies and procedures, provide training and coaching to operational staff, and help establish our reputation for operational excellence and efficiency.',
  published: true
)

job_posting_43 = JobPosting.create(
  recruiter: recruiter_10,
  title: 'Supply Chain Specialist',
  company: 'The Home Depot',
  skills: 'Inventory management, Logistics, Vendor relations, Cost optimization',
  description: 'Manage our supply chain operations and optimize logistics to ensure timely delivery, cost efficiency, and high-quality service delivery across all supply chain activities. You will be responsible for managing inventory levels, coordinating with suppliers and vendors, and implementing logistics strategies that minimize costs while maintaining service quality. Your role will involve analyzing supply chain performance metrics, identifying opportunities for cost reduction and efficiency improvement, and developing relationships with key suppliers and logistics partners. You will work closely with procurement teams to optimize sourcing strategies, collaborate with operations teams to ensure smooth supply chain operations, and contribute to our overall supply chain strategy and continuous improvement initiatives. Additionally, you will stay current with supply chain best practices and technologies, implement new tools and methodologies, and help establish our position as a leader in efficient and effective supply chain management.',
  published: true
)

job_posting_44 = JobPosting.create(
  recruiter: recruiter_10,
  title: 'Quality Assurance Manager',
  company: 'The Home Depot',
  skills: 'Quality standards, Process documentation, Training, Auditing',
  description: 'Maintain quality standards across our organization by developing and implementing comprehensive quality assurance processes, training programs, and auditing systems that ensure consistent quality delivery. You will be responsible for establishing quality standards and procedures, developing quality training programs for staff, and conducting regular audits to ensure compliance with quality requirements and standards. Your role will involve analyzing quality metrics and performance data, identifying areas for improvement, and implementing corrective actions that address quality issues and prevent future problems. You will work closely with operational teams to understand quality requirements, collaborate with training teams to develop quality training materials, and contribute to our overall quality strategy and continuous improvement initiatives. Additionally, you will stay current with quality management best practices and standards, implement new quality tools and methodologies, and help establish our reputation for consistent quality and excellence.',
  published: true
)

job_posting_45 = JobPosting.create(
  recruiter: recruiter_10,
  title: 'Training Coordinator',
  company: 'The Home Depot',
  skills: 'Training development, Learning management, Instructional design, Assessment',
  description: 'Develop and deliver comprehensive training programs that enhance employee skills, improve performance, and support organizational growth and development objectives. You will be responsible for designing training curricula, creating engaging learning materials, and implementing training delivery methods that maximize learning effectiveness and engagement. Your role will involve conducting training needs assessments, developing instructional materials using various formats and technologies, and evaluating training effectiveness through assessments and feedback mechanisms. You will work closely with department heads to understand training requirements, collaborate with subject matter experts to develop training content, and contribute to our overall learning and development strategy. Additionally, you will manage our learning management system, track training completion and effectiveness metrics, and help establish our reputation for excellent employee development and training programs.',
  published: true
)

# Recruiter 11
recruiter_11 = Recruiter.new(email: 'recruiter_11@simplestresumes.com', password: password)
recruiter_11.skip_confirmation!
recruiter_11.save

job_posting_46 = JobPosting.create(
  recruiter: recruiter_11,
  title: 'Research Analyst',
  company: 'Tesla',
  skills: 'Market research, Data analysis, Report writing, Presentation skills',
  description: 'Conduct comprehensive research and provide actionable insights that support strategic decision-making and drive business growth across all areas of our organization. You will be responsible for designing and executing research studies, analyzing market trends and competitive landscapes, and creating detailed reports that communicate findings clearly to stakeholders at all levels. Your role will involve gathering data from various sources including surveys, interviews, and secondary research, analyzing quantitative and qualitative data to identify patterns and opportunities, and presenting research findings through compelling presentations and written reports. You will work closely with product teams to understand research needs, collaborate with marketing teams to inform strategy development, and contribute to our overall research methodology and standards. Additionally, you will stay current with research best practices and methodologies, implement new research tools and techniques, and help establish our position as a data-driven organization that makes informed strategic decisions.',
  published: true
)

job_posting_47 = JobPosting.create(
  recruiter: recruiter_11,
  title: 'Communications Specialist',
  company: 'Tesla',
  skills: 'Written communication, Media relations, Content creation, Crisis communication',
  description: 'Manage our internal and external communications to ensure consistent messaging, strong brand presence, and effective stakeholder engagement across all communication channels and platforms. You will be responsible for developing communication strategies, creating compelling content for various audiences, and managing media relationships to enhance our public image and brand reputation. Your role will involve writing press releases, internal newsletters, and external communications, coordinating with media outlets and journalists, and implementing crisis communication plans when needed to protect our brand and reputation. You will work closely with marketing teams to align communication efforts with overall business objectives, collaborate with senior management to develop key messages, and contribute to our overall communication strategy and brand voice. Additionally, you will stay current with communication trends and best practices, implement new communication tools and platforms, and help establish our reputation for clear, effective, and professional communication.',
  published: true
)

job_posting_48 = JobPosting.create(
  recruiter: recruiter_11,
  title: 'Compliance Officer',
  company: 'Tesla',
  skills: 'Regulatory compliance, Risk assessment, Policy development, Auditing',
  description: 'Ensure regulatory compliance across our organization by developing and implementing comprehensive compliance programs, conducting risk assessments, and establishing policies that protect our business and maintain regulatory standards. You will be responsible for monitoring regulatory changes and requirements, developing compliance policies and procedures, and conducting regular audits to ensure adherence to all applicable laws and regulations. Your role will involve identifying compliance risks and developing mitigation strategies, providing compliance training to staff members, and serving as a resource for compliance-related questions and concerns. You will work closely with legal teams to understand regulatory requirements, collaborate with operational teams to implement compliance measures, and contribute to our overall risk management and compliance strategy. Additionally, you will stay current with regulatory developments and best practices, implement new compliance tools and methodologies, and help establish our reputation for strong compliance and ethical business practices.',
  published: true
)

job_posting_49 = JobPosting.create(
  recruiter: recruiter_11,
  title: 'Procurement Specialist',
  company: 'Tesla',
  skills: 'Vendor management, Contract negotiation, Cost analysis, Supplier evaluation',
  description: 'Manage our procurement processes and vendor relationships to optimize costs, ensure quality, and drive value across all purchasing activities and supplier partnerships. You will be responsible for developing procurement strategies, evaluating and selecting suppliers, negotiating contracts and pricing terms, and managing ongoing vendor relationships to ensure optimal performance and value delivery. Your role will involve analyzing market trends and pricing, conducting cost-benefit analyses for major purchases, and implementing procurement policies and procedures that ensure transparency and compliance. You will work closely with operational teams to understand procurement needs, collaborate with legal teams to develop contract terms, and contribute to our overall procurement strategy and supplier management processes. Additionally, you will stay current with procurement best practices and technologies, implement new procurement tools and methodologies, and help establish our reputation for efficient and effective procurement operations.',
  published: true
)

job_posting_50 = JobPosting.create(
  recruiter: recruiter_11,
  title: 'Facilities Manager',
  company: 'Tesla',
  skills: 'Building maintenance, Space planning, Safety compliance, Vendor management',
  description: 'Manage our facilities and ensure a safe, efficient, and productive work environment that supports business operations and employee wellbeing across all our locations and properties. You will be responsible for overseeing building maintenance and repairs, managing space planning and utilization, and implementing safety and security measures that protect our employees and assets. Your role will involve coordinating with maintenance contractors and service providers, managing facility budgets and expenses, and ensuring compliance with building codes and safety regulations. You will work closely with HR teams to understand workplace needs, collaborate with IT teams on facility technology requirements, and contribute to our overall workplace strategy and facility management processes. Additionally, you will stay current with facility management best practices and technologies, implement new facility management tools and systems, and help establish our reputation for excellent workplace environments and facility operations.',
  published: true
)

# Recruiter 12
recruiter_12 = Recruiter.new(email: 'recruiter_12@simplestresumes.com', password: password)
recruiter_12.skip_confirmation!
recruiter_12.save

job_posting_51 = JobPosting.create(
  recruiter: recruiter_12,
  title: 'Environmental Specialist',
  company: 'Palantir',
  skills: 'Environmental regulations, Sustainability, Waste management, Compliance',
  description: 'Ensure environmental compliance and sustainability across our organization by developing and implementing comprehensive environmental programs, monitoring compliance with regulations, and driving initiatives that reduce our environmental impact and promote sustainable business practices. You will be responsible for monitoring environmental regulations and requirements, developing environmental policies and procedures, and implementing programs that ensure compliance with all applicable environmental laws and standards. Your role will involve conducting environmental assessments and audits, developing waste management and recycling programs, and implementing sustainability initiatives that reduce our carbon footprint and environmental impact. You will work closely with operational teams to understand environmental impacts, collaborate with compliance teams to ensure regulatory adherence, and contribute to our overall environmental strategy and sustainability goals. Additionally, you will stay current with environmental regulations and best practices, implement new environmental management tools and methodologies, and help establish our reputation for environmental responsibility and sustainability leadership.',
  published: true
)

job_posting_52 = JobPosting.create(
  recruiter: recruiter_12,
  title: 'Health and Safety Officer',
  company: 'Palantir',
  skills: 'Safety regulations, Risk assessment, Training, Incident investigation',
  description: 'Maintain workplace safety and health standards by implementing comprehensive safety programs, conducting risk assessments, and providing training that ensures the wellbeing of all employees and compliance with safety regulations. You will be responsible for developing and implementing workplace safety policies and procedures, conducting regular safety inspections and risk assessments, and providing safety training to staff members at all levels of the organization. Your role will involve investigating safety incidents and accidents, identifying root causes and implementing corrective actions, and monitoring safety performance metrics to identify trends and opportunities for improvement. You will work closely with operational teams to understand safety requirements, collaborate with HR teams to implement safety training programs, and contribute to our overall workplace safety strategy and continuous improvement initiatives. Additionally, you will stay current with safety regulations and best practices, implement new safety tools and methodologies, and help establish our reputation for workplace safety excellence and employee protection.',
  published: true
)

job_posting_53 = JobPosting.create(
  recruiter: recruiter_12,
  title: 'Corporate Social Responsibility Manager',
  company: 'Palantir',
  skills: 'Sustainability, Community relations, Stakeholder engagement, Impact measurement',
  description: 'Develop and manage our corporate social responsibility initiatives to create positive social and environmental impact while building strong relationships with communities and stakeholders. You will be responsible for developing CSR strategies and programs, managing community partnerships and initiatives, and measuring and reporting on the social and environmental impact of our business activities. Your role will involve identifying CSR opportunities and priorities, developing partnerships with nonprofit organizations and community groups, and implementing programs that address key social and environmental challenges. You will work closely with executive teams to align CSR initiatives with business objectives, collaborate with marketing teams to communicate CSR efforts, and contribute to our overall sustainability and social responsibility strategy. Additionally, you will stay current with CSR trends and best practices, implement new CSR tools and methodologies, and help establish our reputation as a responsible corporate citizen and sustainability leader.',
  published: true
)

job_posting_54 = JobPosting.create(
  recruiter: recruiter_12,
  title: 'Diversity and Inclusion Specialist',
  company: 'Palantir',
  skills: 'Diversity programs, Training, Policy development, Metrics tracking',
  description: 'Promote diversity and inclusion in our workplace by developing and implementing comprehensive programs, policies, and initiatives that create an inclusive environment where all employees feel valued, respected, and empowered to succeed. You will be responsible for developing diversity and inclusion strategies, creating training programs that promote awareness and understanding, and implementing policies and practices that ensure equal opportunity and fair treatment for all employees. Your role will involve analyzing workforce diversity data, identifying areas for improvement, and developing initiatives that increase representation and create more inclusive workplace cultures. You will work closely with HR teams to integrate D&I principles into all HR processes, collaborate with leadership teams to drive cultural change, and contribute to our overall diversity and inclusion strategy and goals. Additionally, you will stay current with D&I best practices and research, implement new D&I tools and methodologies, and help establish our reputation as a diverse and inclusive employer of choice.',
  published: true
)

job_posting_55 = JobPosting.create(
  recruiter: recruiter_12,
  title: 'Wellness Coordinator',
  company: 'Palantir',
  skills: 'Health programs, Employee engagement, Wellness initiatives, Health education',
  description: 'Promote employee health and wellness by developing and implementing comprehensive wellness programs, initiatives, and activities that improve workplace wellbeing and support healthy lifestyle choices for all employees. You will be responsible for designing wellness programs that address physical, mental, and emotional health needs, organizing wellness events and activities, and providing health education and resources that empower employees to make healthy choices. Your role will involve analyzing employee health data and feedback, identifying wellness priorities and opportunities, and developing initiatives that increase employee engagement and participation in wellness activities. You will work closely with HR teams to integrate wellness into overall employee benefits, collaborate with health providers and wellness partners, and contribute to our overall employee wellbeing strategy and workplace culture. Additionally, you will stay current with wellness trends and best practices, implement new wellness tools and technologies, and help establish our reputation as a workplace that prioritizes employee health and wellbeing.',
  published: true
)

# Recruiter 13
recruiter_13 = Recruiter.new(email: 'recruiter_13@simplestresumes.com', password: password)
recruiter_13.skip_confirmation!
recruiter_13.save

job_posting_56 = JobPosting.create(
  recruiter: recruiter_13,
  title: 'Innovation Manager',
  company: 'Nvidia',
  skills: 'Innovation strategy, R&D management, Technology trends, Partnership development',
  description: 'Drive innovation and research initiatives across our organization by identifying opportunities, managing innovation projects, and developing partnerships that accelerate our technological advancement and competitive positioning. You will be responsible for developing innovation strategies and roadmaps, managing research and development projects, and identifying emerging technologies and trends that could create competitive advantages for our business. Your role will involve scouting for innovative technologies and solutions, developing partnerships with research institutions and technology companies, and managing innovation portfolios that balance short-term opportunities with long-term strategic initiatives. You will work closely with product teams to identify innovation opportunities, collaborate with business development teams to explore partnership opportunities, and contribute to our overall innovation strategy and technology roadmap. Additionally, you will stay current with innovation trends and best practices, implement new innovation tools and methodologies, and help establish our position as an innovation leader in our industry.',
  published: true
)

job_posting_57 = JobPosting.create(
  recruiter: recruiter_13,
  title: 'Intellectual Property Specialist',
  company: 'Nvidia',
  skills: 'Patent law, Trademark protection, IP strategy, Legal research',
  description: 'Protect our intellectual property assets by developing and implementing comprehensive IP strategies, managing patent and trademark portfolios, and ensuring proper protection of our innovations, brands, and proprietary technologies. You will be responsible for conducting IP research and analysis, developing IP protection strategies, and managing the filing and prosecution of patent and trademark applications to secure our intellectual property rights. Your role will involve monitoring IP landscapes and competitive activities, conducting freedom-to-operate analyses, and developing IP strategies that align with our business objectives and innovation goals. You will work closely with legal teams to ensure proper IP protection, collaborate with R&D teams to identify patentable inventions, and contribute to our overall IP strategy and asset management processes. Additionally, you will stay current with IP law developments and best practices, implement new IP management tools and systems, and help establish our reputation for strong IP protection and strategic IP management.',
  published: true
)

job_posting_58 = JobPosting.create(
  recruiter: recruiter_13,
  title: 'Technology Transfer Officer',
  company: 'Nvidia',
  skills: 'Technology licensing, Commercialization, Partnership development, Market analysis',
  description: 'Facilitate technology transfer and commercialization by identifying opportunities, developing partnerships, and managing the process of bringing innovative technologies from research to market. You will be responsible for evaluating technologies for commercial potential, developing commercialization strategies, and negotiating licensing agreements and partnerships that maximize the value of our intellectual property and research investments. Your role will involve conducting market analyses and competitive assessments, identifying potential partners and licensees, and managing the technology transfer process from initial evaluation through successful commercialization. You will work closely with research teams to understand technology capabilities, collaborate with business development teams to explore partnership opportunities, and contribute to our overall technology commercialization strategy and processes. Additionally, you will stay current with technology transfer best practices and industry trends, implement new commercialization tools and methodologies, and help establish our position as a leader in technology transfer and commercialization.',
  published: true
)

job_posting_59 = JobPosting.create(
  recruiter: recruiter_13,
  title: 'R&D Engineer',
  company: 'Nvidia',
  skills: 'Research methodology, Prototyping, Testing, Documentation',
  description: 'Conduct research and development activities that drive innovation, solve technical challenges, and create new products and technologies that provide competitive advantages for our business. You will be responsible for designing and conducting research experiments, developing prototypes and proof-of-concepts, and testing new technologies and solutions to validate their feasibility and performance. Your role will involve working with cross-functional teams to understand research requirements, collaborating with subject matter experts to develop research methodologies, and documenting research findings and technical specifications for future development and implementation. You will work closely with product teams to understand technical challenges, collaborate with innovation teams to explore new technologies, and contribute to our overall R&D strategy and technology development processes. Additionally, you will stay current with research methodologies and emerging technologies, implement new research tools and techniques, and help establish our reputation for innovative research and technical excellence.',
  published: true
)

job_posting_60 = JobPosting.create(
  recruiter: recruiter_13,
  title: 'Laboratory Manager',
  company: 'Nvidia',
  skills: 'Lab operations, Equipment maintenance, Safety protocols, Quality control',
  description: 'Manage laboratory operations and ensure quality standards by overseeing lab safety, equipment maintenance, and operational procedures that support our research and development activities. You will be responsible for managing laboratory facilities and equipment, implementing safety protocols and procedures, and ensuring compliance with all laboratory safety and quality standards. Your role will involve coordinating laboratory schedules and resources, managing equipment maintenance and calibration, and implementing quality control procedures that ensure accurate and reliable research results. You will work closely with research teams to understand laboratory needs, collaborate with safety teams to maintain compliance, and contribute to our overall laboratory management strategy and operational excellence. Additionally, you will stay current with laboratory best practices and safety standards, implement new laboratory management tools and systems, and help establish our reputation for safe, efficient, and high-quality laboratory operations.',
  published: true
)

# Recruiter 14
recruiter_14 = Recruiter.new(email: 'recruiter_14@simplestresumes.com', password: password)
recruiter_14.skip_confirmation!
recruiter_14.save

job_posting_61 = JobPosting.create(
  recruiter: recruiter_14,
  title: 'Clinical Research Coordinator',
  company: 'Apple',
  skills: 'Clinical trials, Patient recruitment, Data collection, Regulatory compliance',
  description: 'Coordinate clinical research studies and ensure successful execution of clinical trials by managing all aspects of trial logistics, patient recruitment, and regulatory compliance. You will be responsible for coordinating with clinical sites, managing patient recruitment strategies, and ensuring all trial activities comply with regulatory requirements and Good Clinical Practice (GCP) standards. Your role will involve developing and implementing study protocols, coordinating with investigators and clinical staff, and managing data collection and quality control processes. You will work closely with regulatory teams to ensure compliance with FDA and other regulatory requirements, collaborate with data management teams to ensure data quality and integrity, and contribute to our overall clinical research strategy and operational excellence. Additionally, you will stay current with clinical research regulations and best practices, implement new clinical trial management tools and systems, and help establish our reputation for high-quality clinical research and regulatory compliance.',
  published: true
)

job_posting_62 = JobPosting.create(
  recruiter: recruiter_14,
  title: 'Medical Writer',
  company: 'Apple',
  skills: 'Medical writing, Scientific literature, Regulatory documents, Clinical reports',
  description: 'Create comprehensive medical and scientific content that communicates complex clinical information clearly and accurately to healthcare professionals, regulatory authorities, and other stakeholders. You will be responsible for writing clinical study reports, regulatory submissions, scientific publications, and other medical documents that meet industry standards and regulatory requirements. Your role will involve researching scientific literature, analyzing clinical data, and translating complex medical information into clear, compelling content that supports our clinical development and regulatory objectives. You will work closely with clinical teams to understand study results and data, collaborate with regulatory teams to ensure document compliance, and contribute to our overall medical communication strategy and content development processes. Additionally, you will stay current with medical writing standards and best practices, implement new writing tools and methodologies, and help establish our reputation for high-quality medical communication and scientific excellence.',
  published: true
)

job_posting_63 = JobPosting.create(
  recruiter: recruiter_14,
  title: 'Regulatory Affairs Specialist',
  company: 'Apple',
  skills: 'FDA regulations, Regulatory submissions, Compliance, Documentation',
  description: 'Ensure regulatory compliance for our products by managing regulatory submissions, maintaining compliance with FDA and other regulatory requirements, and developing regulatory strategies that support successful product development and market approval. You will be responsible for preparing and submitting regulatory documents, monitoring regulatory changes and requirements, and ensuring all regulatory activities comply with applicable laws and standards. Your role will involve developing regulatory strategies and timelines, coordinating with cross-functional teams to gather required information, and managing ongoing regulatory compliance activities throughout the product lifecycle. You will work closely with clinical teams to ensure regulatory compliance in clinical trials, collaborate with quality teams to maintain compliance standards, and contribute to our overall regulatory strategy and compliance processes. Additionally, you will stay current with regulatory developments and requirements, implement new regulatory tools and systems, and help establish our reputation for strong regulatory compliance and successful product approvals.',
  published: true
)

job_posting_64 = JobPosting.create(
  recruiter: recruiter_14,
  title: 'Quality Control Analyst',
  company: 'Apple',
  skills: 'Laboratory testing, Quality standards, Documentation, Equipment calibration',
  description: 'Perform comprehensive quality control testing and analysis to ensure product quality, safety, and compliance with all applicable quality standards and regulatory requirements. You will be responsible for conducting laboratory tests and analyses, maintaining quality control procedures and documentation, and ensuring all testing activities meet established quality standards and regulatory requirements. Your role will involve performing routine and non-routine quality control tests, analyzing test results and identifying trends, and implementing corrective actions when quality issues are identified. You will work closely with quality assurance teams to maintain quality standards, collaborate with laboratory teams to optimize testing processes, and contribute to our overall quality control strategy and operational excellence. Additionally, you will stay current with quality control best practices and technologies, implement new testing methodologies and equipment, and help establish our reputation for high-quality testing and reliable results.',
  published: true
)

job_posting_65 = JobPosting.create(
  recruiter: recruiter_14,
  title: 'Biostatistician',
  company: 'Apple',
  skills: 'Statistical analysis, Clinical data, SAS, R programming',
  description: 'Analyze clinical and research data using advanced statistical methods to provide insights that support clinical decision-making, regulatory submissions, and scientific research objectives. You will be responsible for designing statistical analysis plans, conducting statistical analyses of clinical data, and interpreting results to provide actionable insights for clinical development and research teams. Your role will involve working with large datasets, implementing statistical methodologies for clinical trials, and developing statistical models that support research objectives and regulatory requirements. You will work closely with clinical teams to understand study designs and data requirements, collaborate with data management teams to ensure data quality, and contribute to our overall statistical analysis strategy and research methodology. Additionally, you will stay current with statistical methodologies and software tools, implement new statistical approaches and technologies, and help establish our reputation for statistical excellence and data-driven decision making.',
  published: true
)

# Recruiter 15
recruiter_15 = Recruiter.new(email: 'recruiter_15@simplestresumes.com', password: password)
recruiter_15.skip_confirmation!
recruiter_15.save

job_posting_66 = JobPosting.create(
  recruiter: recruiter_15,
  title: 'Pharmacovigilance Specialist',
  company: 'Shopify',
  skills: 'Drug safety, Adverse event reporting, Risk assessment, Regulatory compliance',
  description: 'Monitor drug safety and report adverse events to ensure patient safety and regulatory compliance throughout the product lifecycle. You will be responsible for collecting, analyzing, and reporting adverse event data, conducting safety signal detection and evaluation, and implementing risk management strategies that protect patient safety. Your role will involve monitoring safety databases, conducting safety assessments and risk evaluations, and preparing safety reports for regulatory authorities and internal stakeholders. You will work closely with clinical teams to monitor safety in clinical trials, collaborate with regulatory teams to ensure compliance with safety reporting requirements, and contribute to our overall drug safety strategy and pharmacovigilance processes. Additionally, you will stay current with pharmacovigilance regulations and best practices, implement new safety monitoring tools and systems, and help establish our reputation for strong drug safety monitoring and patient protection.',
  published: true
)

job_posting_67 = JobPosting.create(
  recruiter: recruiter_15,
  title: 'Medical Device Specialist',
  company: 'Shopify',
  skills: 'Medical devices, FDA regulations, Quality systems, Risk management',
  description: 'Ensure compliance for medical devices by managing quality systems, regulatory requirements, and risk management processes that support successful device development and market approval. You will be responsible for developing and implementing quality management systems, ensuring compliance with FDA and other regulatory requirements, and managing risk assessment and mitigation strategies for medical devices. Your role will involve coordinating regulatory submissions, managing quality system documentation, and implementing risk management processes that identify and mitigate potential device risks. You will work closely with engineering teams to ensure device design compliance, collaborate with quality teams to maintain quality standards, and contribute to our overall medical device strategy and regulatory compliance processes. Additionally, you will stay current with medical device regulations and best practices, implement new quality and risk management tools, and help establish our reputation for strong medical device compliance and quality excellence.',
  published: true
)

job_posting_68 = JobPosting.create(
  recruiter: recruiter_15,
  title: 'Clinical Data Manager',
  company: 'Shopify',
  skills: 'Data management, Clinical databases, Quality control, Statistical analysis',
  description: 'Manage clinical trial data and ensure data quality by overseeing data collection, validation, and management processes that support successful clinical research and regulatory submissions. You will be responsible for designing data collection systems, implementing data quality control procedures, and managing clinical databases to ensure data integrity and compliance with regulatory requirements. Your role will involve developing data management plans, coordinating data collection activities across clinical sites, and implementing data validation and quality control processes. You will work closely with clinical teams to understand data requirements, collaborate with statistical teams to ensure data quality for analysis, and contribute to our overall clinical data management strategy and operational excellence. Additionally, you will stay current with data management best practices and technologies, implement new data management tools and systems, and help establish our reputation for high-quality clinical data management and regulatory compliance.',
  published: false
)

job_posting_69 = JobPosting.create(
  recruiter: recruiter_15,
  title: 'Medical Affairs Specialist',
  company: 'Shopify',
  skills: 'Medical information, Healthcare provider relations, Scientific communication, Clinical support',
  description: 'Provide comprehensive medical and scientific support to healthcare providers, internal teams, and external stakeholders to ensure accurate medical information and support clinical decision-making. You will be responsible for developing and delivering medical information, building relationships with healthcare providers, and providing scientific support for clinical activities and product development. Your role will involve responding to medical inquiries, developing medical education materials, and supporting clinical research and development activities. You will work closely with clinical teams to understand product information and clinical data, collaborate with marketing teams to ensure accurate medical communication, and contribute to our overall medical affairs strategy and scientific communication processes. Additionally, you will stay current with medical developments and best practices, implement new medical information tools and systems, and help establish our reputation for strong medical support and scientific excellence.',
  published: true
)

job_posting_70 = JobPosting.create(
  recruiter: recruiter_15,
  title: 'Health Economics Specialist',
  company: 'Shopify',
  skills: 'Health economics, Cost-effectiveness analysis, Market access, Health policy',
  description: 'Analyze health economics and market access to support pricing strategies, reimbursement decisions, and market access initiatives that ensure patient access to our products. You will be responsible for conducting health economic evaluations, analyzing cost-effectiveness data, and developing economic models that support pricing and reimbursement strategies. Your role will involve analyzing healthcare costs and outcomes, developing economic models for health technology assessments, and supporting market access strategies with health economic evidence. You will work closely with market access teams to develop reimbursement strategies, collaborate with clinical teams to understand product value propositions, and contribute to our overall health economics strategy and market access processes. Additionally, you will stay current with health economics methodologies and best practices, implement new economic analysis tools and models, and help establish our reputation for strong health economic analysis and market access support.',
  published: true
)

# Recruiter 16
recruiter_16 = Recruiter.new(email: 'recruiter_16@simplestresumes.com', password: password)
recruiter_16.skip_confirmation!
recruiter_16.save

job_posting_71 = JobPosting.create(
  recruiter: recruiter_16,
  title: 'Market Access Manager',
  company: 'JP Morgan',
  skills: 'Market access, Reimbursement, Health policy, Stakeholder engagement',
  description: 'Develop comprehensive market access strategies that ensure patient access to our products by working with payers, policymakers, and other stakeholders to secure reimbursement and market access. You will be responsible for developing market access strategies, building relationships with key stakeholders, and implementing initiatives that support successful market access and reimbursement. Your role will involve analyzing healthcare policies and reimbursement environments, developing value propositions for payers, and coordinating market access activities across different markets and healthcare systems. You will work closely with health economics teams to develop economic evidence, collaborate with clinical teams to understand product value, and contribute to our overall market access strategy and stakeholder engagement processes. Additionally, you will stay current with market access trends and best practices, implement new market access tools and strategies, and help establish our reputation for strong market access and successful reimbursement.',
  published: true
)

job_posting_72 = JobPosting.create(
  recruiter: recruiter_16,
  title: 'Pricing Strategy Manager',
  company: 'JP Morgan',
  skills: 'Pricing strategy, Market analysis, Competitive intelligence, Financial modeling',
  description: 'Develop comprehensive pricing strategies for our products by analyzing market dynamics, competitive landscapes, and financial considerations to optimize pricing decisions and maximize product value. You will be responsible for conducting market analyses, developing pricing models, and implementing pricing strategies that balance business objectives with market realities and competitive pressures. Your role will involve analyzing pricing trends and competitive pricing strategies, developing financial models to evaluate pricing scenarios, and coordinating pricing decisions across different markets and product lines. You will work closely with market access teams to understand reimbursement implications, collaborate with finance teams to evaluate financial impact, and contribute to our overall pricing strategy and market positioning processes. Additionally, you will stay current with pricing best practices and market trends, implement new pricing tools and methodologies, and help establish our reputation for strategic pricing and market leadership.',
  published: true
)

job_posting_73 = JobPosting.create(
  recruiter: recruiter_16,
  title: 'Commercial Analytics Manager',
  company: 'JP Morgan',
  skills: 'Sales analytics, Market research, Data analysis, Business intelligence',
  description: 'Provide comprehensive commercial insights and analytics that support strategic decision-making and drive commercial success across all aspects of our business operations. You will be responsible for analyzing sales data, market trends, and business performance metrics to provide actionable insights that support commercial strategy and operational decisions. Your role will involve developing analytical models and dashboards, conducting market research and competitive analysis, and providing regular reporting and insights to commercial teams and senior management. You will work closely with sales teams to understand performance drivers, collaborate with marketing teams to evaluate campaign effectiveness, and contribute to our overall commercial analytics strategy and business intelligence processes. Additionally, you will stay current with analytics best practices and technologies, implement new analytical tools and methodologies, and help establish our reputation for data-driven commercial decision making and strategic insights.',
  published: false
)

job_posting_74 = JobPosting.create(
  recruiter: recruiter_16,
  title: 'Key Account Manager',
  company: 'JP Morgan',
  skills: 'Account management, Relationship building, Sales strategy, Customer success',
  description: 'Manage key customer relationships and develop strategic account strategies that drive customer success, increase account value, and build long-term partnerships that support business growth and market expansion. You will be responsible for developing and executing account strategies, building strong relationships with key stakeholders, and driving customer success initiatives that increase account value and customer satisfaction. Your role will involve understanding customer needs and objectives, developing customized solutions and strategies, and coordinating with internal teams to ensure successful delivery and customer satisfaction. You will work closely with sales teams to develop account strategies, collaborate with customer success teams to drive value, and contribute to our overall key account management strategy and customer relationship processes. Additionally, you will stay current with account management best practices and customer success methodologies, implement new account management tools and processes, and help establish our reputation for strong customer relationships and strategic account management.',
  published: true
)

job_posting_75 = JobPosting.create(
  recruiter: recruiter_16,
  title: 'Sales Operations Manager',
  company: 'JP Morgan',
  skills: 'Sales operations, Process optimization, CRM management, Performance analytics',
  description: 'Optimize sales operations and processes to improve sales efficiency, effectiveness, and performance across all sales activities and customer interactions. You will be responsible for analyzing sales processes, identifying opportunities for improvement, and implementing solutions that enhance sales productivity and performance. Your role will involve managing CRM systems and sales tools, developing sales processes and procedures, and analyzing sales performance metrics to identify trends and opportunities for improvement. You will work closely with sales teams to understand operational needs, collaborate with IT teams to implement sales technology solutions, and contribute to our overall sales operations strategy and process optimization initiatives. Additionally, you will stay current with sales operations best practices and technologies, implement new sales tools and processes, and help establish our reputation for efficient and effective sales operations and performance excellence.',
  published: true
)

# Recruiter 17
recruiter_17 = Recruiter.new(email: 'recruiter_17@simplestresumes.com', password: password)
recruiter_17.skip_confirmation!
recruiter_17.save

job_posting_76 = JobPosting.create(
  recruiter: recruiter_17,
  title: 'Channel Sales Manager',
  company: 'Bank of America',
  skills: 'Channel management, Partner development, Sales strategy, Relationship building',
  description: 'Develop and manage comprehensive sales channels through strategic partnerships and channel development initiatives that expand market reach and drive sales growth across multiple distribution channels. You will be responsible for identifying and developing channel partners, building strong partner relationships, and implementing channel strategies that maximize sales opportunities and market coverage. Your role will involve developing channel partner programs, providing training and support to partners, and coordinating channel activities to ensure consistent sales performance and customer satisfaction. You will work closely with sales teams to align channel strategies, collaborate with marketing teams to develop channel marketing programs, and contribute to our overall channel sales strategy and partner development processes. Additionally, you will stay current with channel sales best practices and industry trends, implement new channel management tools and processes, and help establish our reputation for strong channel partnerships and successful channel sales performance.',
  published: true
)

job_posting_77 = JobPosting.create(
  recruiter: recruiter_17,
  title: 'Inside Sales Representative',
  company: 'Bank of America',
  skills: 'Inside sales, Lead qualification, Product knowledge, Customer service',
  description: 'Generate sales through comprehensive inside sales activities that qualify leads, build customer relationships, and close deals remotely while providing exceptional customer service and product expertise. You will be responsible for prospecting for new customers, qualifying sales leads, and managing the entire sales process from initial contact through deal closure. Your role will involve conducting product demonstrations, preparing sales proposals, and negotiating terms and conditions to achieve sales targets and customer satisfaction. You will work closely with marketing teams to follow up on marketing-generated leads, collaborate with customer success teams to ensure smooth handoffs, and contribute to our overall inside sales strategy and lead management processes. Additionally, you will stay current with sales best practices and product knowledge, implement new sales tools and technologies, and help establish our reputation for strong inside sales performance and customer relationship building.',
  published: true
)

job_posting_78 = JobPosting.create(
  recruiter: recruiter_17,
  title: 'Sales Training Manager',
  company: 'Bank of America',
  skills: 'Sales training, Curriculum development, Coaching, Performance improvement',
  description: 'Develop and deliver comprehensive sales training programs that improve sales team performance, enhance selling skills, and drive sales success through continuous learning and development initiatives. You will be responsible for designing sales training curricula, developing training materials and resources, and delivering training programs that address specific sales challenges and opportunities. Your role will involve conducting training needs assessments, developing customized training solutions, and providing ongoing coaching and support to sales team members. You will work closely with sales managers to understand training requirements, collaborate with product teams to develop product training content, and contribute to our overall sales training strategy and performance improvement processes. Additionally, you will stay current with sales training best practices and methodologies, implement new training tools and technologies, and help establish our reputation for excellent sales training and team development.',
  published: false
)

job_posting_79 = JobPosting.create(
  recruiter: recruiter_17,
  title: 'Sales Enablement Specialist',
  company: 'Bank of America',
  skills: 'Sales enablement, Content creation, Tool management, Performance analytics',
  description: 'Enable sales success through comprehensive tools, content, and resources that support sales teams in achieving their targets and delivering exceptional customer experiences. You will be responsible for developing sales enablement strategies, creating sales content and collateral, and managing sales tools and technologies that enhance sales productivity and effectiveness. Your role will involve analyzing sales performance data, identifying enablement opportunities, and implementing solutions that address specific sales challenges and improve overall sales performance. You will work closely with sales teams to understand enablement needs, collaborate with marketing teams to develop sales content, and contribute to our overall sales enablement strategy and tool management processes. Additionally, you will stay current with sales enablement best practices and technologies, implement new enablement tools and processes, and help establish our reputation for strong sales enablement and sales team support.',
  published: true
)

job_posting_80 = JobPosting.create(
  recruiter: recruiter_17,
  title: 'Customer Experience Manager',
  company: 'Bank of America',
  skills: 'Customer experience, Journey mapping, Feedback analysis, Process improvement',
  description: 'Improve customer experience across all touchpoints by implementing comprehensive customer experience strategies, mapping customer journeys, and optimizing processes that enhance customer satisfaction and loyalty. You will be responsible for developing customer experience strategies, mapping customer journeys and touchpoints, and analyzing customer feedback to identify opportunities for improvement and optimization. Your role will involve working with cross-functional teams to implement customer experience improvements, coordinating customer experience initiatives, and measuring the impact of changes on customer satisfaction and business outcomes. You will work closely with customer success teams to understand customer needs, collaborate with product teams to improve product experiences, and contribute to our overall customer experience strategy and continuous improvement processes. Additionally, you will stay current with customer experience best practices and methodologies, implement new experience design tools and processes, and help establish our reputation for exceptional customer experiences and strong customer relationships.',
  published: true
)

# Recruiter 18
recruiter_18 = Recruiter.new(email: 'recruiter_18@simplestresumes.com', password: password)
recruiter_18.skip_confirmation!
recruiter_18.save

job_posting_81 = JobPosting.create(
  recruiter: recruiter_18,
  title: 'Customer Insights Manager',
  company: 'Wells Fargo',
  skills: 'Customer research, Data analysis, Voice of customer, Market insights',
  description: 'Generate comprehensive customer insights and intelligence through systematic research, data analysis, and voice of customer programs that inform strategic decision-making and drive customer-centric business strategies. You will be responsible for designing and conducting customer research studies, analyzing customer data and feedback, and developing insights that support product development, marketing strategies, and business decisions. Your role will involve implementing voice of customer programs, conducting customer interviews and surveys, and analyzing customer behavior data to identify trends, opportunities, and areas for improvement. You will work closely with product teams to understand customer needs, collaborate with marketing teams to inform customer strategies, and contribute to our overall customer insights strategy and research methodology. Additionally, you will stay current with customer research best practices and methodologies, implement new research tools and technologies, and help establish our reputation for strong customer insights and data-driven decision making.',
  published: true
)

job_posting_82 = JobPosting.create(
  recruiter: recruiter_18,
  title: 'Loyalty Program Manager',
  company: 'Wells Fargo',
  skills: 'Loyalty programs, Customer retention, Rewards management, Program optimization',
  description: 'Develop and manage comprehensive customer loyalty programs that increase customer retention, drive engagement, and build long-term customer relationships through strategic rewards and recognition initiatives. You will be responsible for designing loyalty program strategies, developing reward structures and benefits, and implementing programs that encourage customer engagement and repeat business. Your role will involve analyzing customer behavior and loyalty data, optimizing program performance, and developing initiatives that increase customer participation and satisfaction. You will work closely with marketing teams to promote loyalty programs, collaborate with customer success teams to understand customer needs, and contribute to our overall customer retention strategy and loyalty program management processes. Additionally, you will stay current with loyalty program best practices and industry trends, implement new loyalty technologies and tools, and help establish our reputation for strong customer loyalty and retention programs.',
  published: true
)

job_posting_83 = JobPosting.create(
  recruiter: recruiter_18,
  title: 'Customer Advocacy Manager',
  company: 'Wells Fargo',
  skills: 'Customer advocacy, Reference programs, Case studies, Success stories',
  description: 'Build comprehensive customer advocacy and reference programs that showcase customer success, build strong relationships, and leverage customer testimonials and case studies to support business growth and market expansion. You will be responsible for developing customer advocacy strategies, building reference customer programs, and creating compelling case studies and success stories that demonstrate product value and customer success. Your role will involve identifying and cultivating customer advocates, coordinating reference customer activities, and developing content that supports sales and marketing efforts. You will work closely with customer success teams to identify advocacy opportunities, collaborate with marketing teams to develop customer content, and contribute to our overall customer advocacy strategy and reference program management processes. Additionally, you will stay current with customer advocacy best practices and methodologies, implement new advocacy tools and processes, and help establish our reputation for strong customer relationships and successful customer advocacy programs.',
  published: false
)

job_posting_84 = JobPosting.create(
  recruiter: recruiter_18,
  title: 'Customer Support Manager',
  company: 'Wells Fargo',
  skills: 'Support operations, Team leadership, Process improvement, Customer satisfaction',
  description: 'Manage comprehensive customer support operations and lead support teams to ensure high customer satisfaction, support quality, and operational excellence across all customer support activities and interactions. You will be responsible for managing customer support operations, leading support teams, and implementing processes that ensure timely and effective customer support delivery. Your role will involve analyzing support performance metrics, identifying process improvement opportunities, and implementing solutions that enhance support efficiency and customer satisfaction. You will work closely with customer success teams to coordinate support activities, collaborate with product teams to understand product issues, and contribute to our overall customer support strategy and operational excellence processes. Additionally, you will stay current with customer support best practices and technologies, implement new support tools and processes, and help establish our reputation for excellent customer support and high customer satisfaction.',
  published: true
)

job_posting_85 = JobPosting.create(
  recruiter: recruiter_18,
  title: 'Customer Success Operations Manager',
  company: 'Wells Fargo',
  skills: 'Customer success operations, Process optimization, Tool management, Performance analytics',
  description: 'Optimize customer success operations and processes to improve efficiency, effectiveness, and overall customer success performance through systematic process improvement and tool optimization initiatives. You will be responsible for analyzing customer success operations, identifying process optimization opportunities, and implementing solutions that enhance operational efficiency and customer success outcomes. Your role will involve managing customer success tools and technologies, developing operational processes and procedures, and analyzing performance metrics to identify trends and opportunities for improvement. You will work closely with customer success teams to understand operational needs, collaborate with IT teams to implement technology solutions, and contribute to our overall customer success operations strategy and process optimization initiatives. Additionally, you will stay current with customer success operations best practices and technologies, implement new operational tools and processes, and help establish our reputation for efficient and effective customer success operations.',
  published: true
)

# Recruiter 19
recruiter_19 = Recruiter.new(email: 'recruiter_19@simplestresumes.com', password: password)
recruiter_19.skip_confirmation!
recruiter_19.save

job_posting_86 = JobPosting.create(
  recruiter: recruiter_19,
  title: 'Customer Success Engineer',
  company: 'Walmart',
  skills: 'Technical support, Product knowledge, Customer training, Problem solving',
  description: 'Provide comprehensive technical support and guidance to customers to ensure successful product adoption, resolve technical challenges, and maximize customer value through expert product knowledge and problem-solving capabilities. You will be responsible for providing technical support to customers, conducting product training sessions, and solving complex technical problems that may arise during product implementation and usage. Your role will involve understanding customer technical requirements, developing customized solutions, and providing ongoing technical guidance to ensure successful product outcomes and customer satisfaction. You will work closely with customer success teams to understand customer needs, collaborate with product teams to stay current with product features, and contribute to our overall customer success strategy and technical support processes. Additionally, you will stay current with product technologies and best practices, implement new technical support tools and methodologies, and help establish our reputation for strong technical support and customer success engineering.',
  published: true
)

job_posting_87 = JobPosting.create(
  recruiter: recruiter_19,
  title: 'Implementation Manager',
  company: 'Walmart',
  skills: 'Project management, Customer onboarding, Technical implementation, Training',
  description: 'Manage comprehensive customer implementation projects to ensure successful product deployment, adoption, and customer satisfaction through effective project management and technical implementation processes. You will be responsible for managing customer implementation projects, coordinating technical implementation activities, and ensuring successful product deployment and customer onboarding. Your role will involve developing implementation plans and timelines, coordinating with technical teams and customers, and providing training and support to ensure successful product adoption and usage. You will work closely with customer success teams to understand customer requirements, collaborate with technical teams to coordinate implementation activities, and contribute to our overall implementation strategy and project management processes. Additionally, you will stay current with implementation best practices and methodologies, implement new implementation tools and processes, and help establish our reputation for successful product implementations and strong customer onboarding experiences.',
  published: true
)

job_posting_88 = JobPosting.create(
  recruiter: recruiter_19,
  title: 'Professional Services Manager',
  company: 'Walmart',
  skills: 'Professional services, Project delivery, Client management, Service optimization',
  description: 'Manage comprehensive professional services delivery and client relationships to ensure high-quality service delivery, client satisfaction, and successful project outcomes across all professional services engagements. You will be responsible for managing professional services delivery, building and maintaining client relationships, and ensuring successful project delivery and client satisfaction. Your role will involve coordinating service delivery activities, managing client expectations and communications, and optimizing service delivery processes to improve efficiency and quality. You will work closely with service delivery teams to coordinate activities, collaborate with sales teams to understand client requirements, and contribute to our overall professional services strategy and service optimization processes. Additionally, you will stay current with professional services best practices and methodologies, implement new service delivery tools and processes, and help establish our reputation for high-quality professional services and strong client relationships.',
  published: false
)

job_posting_89 = JobPosting.create(
  recruiter: recruiter_19,
  title: 'Customer Education Manager',
  company: 'Walmart',
  skills: 'Training programs, Content development, Learning management, Skill assessment',
  description: 'Develop and manage comprehensive customer education programs that help customers build skills, knowledge, and capabilities to maximize product value and achieve their business objectives through effective learning and development initiatives. You will be responsible for designing customer education strategies, developing training programs and content, and managing learning management systems that support customer skill development and product adoption. Your role will involve conducting training needs assessments, developing customized learning solutions, and measuring the effectiveness of education programs to ensure customer success and satisfaction. You will work closely with customer success teams to understand education needs, collaborate with product teams to develop product training content, and contribute to our overall customer education strategy and learning management processes. Additionally, you will stay current with education best practices and technologies, implement new learning tools and methodologies, and help establish our reputation for excellent customer education and skill development programs.',
  published: true
)

job_posting_90 = JobPosting.create(
  recruiter: recruiter_19,
  title: 'Customer Community Manager',
  company: 'Walmart',
  skills: 'Community management, Engagement strategies, Content moderation, Member growth',
  description: 'Build and manage comprehensive customer communities that foster engagement, create value for members, and build strong customer relationships through strategic community development and management initiatives. You will be responsible for developing community strategies, building and growing customer communities, and implementing engagement strategies that encourage active participation and community value creation. Your role will involve creating community content and activities, moderating community discussions, and developing initiatives that increase member engagement and community growth. You will work closely with customer success teams to understand community needs, collaborate with marketing teams to promote community activities, and contribute to our overall customer community strategy and community management processes. Additionally, you will stay current with community management best practices and technologies, implement new community tools and platforms, and help establish our reputation for strong customer communities and high member engagement.',
  published: true
)

# Recruiter 20
recruiter_20 = Recruiter.new(email: 'recruiter_20@simplestresumes.com', password: password)
recruiter_20.skip_confirmation!
recruiter_20.save

job_posting_91 = JobPosting.create(
  recruiter: recruiter_20,
  title: 'Customer Feedback Manager',
  company: 'ExxonMobil',
  skills: 'Feedback collection, Survey design, Data analysis, Action planning',
  description: 'Collect and analyze comprehensive customer feedback through systematic feedback collection programs, survey design, and data analysis to drive continuous improvement and enhance customer satisfaction across all products and services. You will be responsible for developing customer feedback strategies, designing and implementing feedback collection programs, and analyzing feedback data to identify trends, opportunities, and areas for improvement. Your role will involve designing customer surveys and feedback mechanisms, analyzing feedback data and sentiment, and developing action plans that address customer concerns and improve overall customer experience. You will work closely with customer success teams to understand feedback priorities, collaborate with product teams to implement feedback-driven improvements, and contribute to our overall customer feedback strategy and continuous improvement processes. Additionally, you will stay current with feedback collection best practices and methodologies, implement new feedback tools and technologies, and help establish our reputation for strong customer feedback collection and data-driven improvement.',
  published: true
)

job_posting_92 = JobPosting.create(
  recruiter: recruiter_20,
  title: 'Customer Journey Manager',
  company: 'ExxonMobil',
  skills: 'Journey mapping, Touchpoint optimization, Experience design, Process improvement',
  description: 'Map and optimize comprehensive customer journeys across all touchpoints to improve customer experience, enhance satisfaction, and drive business outcomes through strategic journey mapping and experience optimization initiatives. You will be responsible for developing customer journey strategies, mapping customer journeys and touchpoints, and identifying opportunities for experience improvement and optimization across all customer interactions. Your role will involve analyzing customer journey data, identifying pain points and opportunities, and implementing solutions that enhance customer experience and improve business outcomes. You will work closely with customer success teams to understand journey requirements, collaborate with product teams to improve product experiences, and contribute to our overall customer journey strategy and experience optimization processes. Additionally, you will stay current with journey mapping best practices and methodologies, implement new journey analysis tools and processes, and help establish our reputation for excellent customer journeys and strong customer experience design.',
  published: true
)

job_posting_93 = JobPosting.create(
  recruiter: recruiter_20,
  title: 'Customer Retention Manager',
  company: 'ExxonMobil',
  skills: 'Retention strategies, Churn analysis, Loyalty programs, Customer engagement',
  description: 'Develop comprehensive customer retention strategies that reduce churn, increase customer lifetime value, and build long-term customer relationships through strategic retention initiatives and customer engagement programs. You will be responsible for developing customer retention strategies, analyzing churn patterns and drivers, and implementing initiatives that increase customer retention and loyalty. Your role will involve developing customer engagement programs, implementing retention campaigns, and analyzing retention metrics to identify trends and opportunities for improvement. You will work closely with customer success teams to understand retention challenges, collaborate with marketing teams to develop retention campaigns, and contribute to our overall customer retention strategy and loyalty development processes. Additionally, you will stay current with retention best practices and methodologies, implement new retention tools and technologies, and help establish our reputation for strong customer retention and high customer lifetime value.',
  published: false
)

job_posting_94 = JobPosting.create(
  recruiter: recruiter_20,
  title: 'Customer Growth Manager',
  company: 'ExxonMobil',
  skills: 'Growth strategies, Upselling, Cross-selling, Expansion opportunities',
  description: 'Drive comprehensive customer growth and expansion through strategic growth initiatives, upselling and cross-selling programs, and expansion strategies that increase customer value and business growth across all customer segments and markets. You will be responsible for developing customer growth strategies, identifying expansion opportunities, and implementing initiatives that increase customer value and drive business growth. Your role will involve analyzing customer data and behavior, developing upselling and cross-selling programs, and identifying expansion opportunities that align with customer needs and business objectives. You will work closely with sales teams to develop growth strategies, collaborate with customer success teams to identify expansion opportunities, and contribute to our overall customer growth strategy and business expansion processes. Additionally, you will stay current with customer growth best practices and methodologies, implement new growth tools and technologies, and help establish our reputation for strong customer growth and successful business expansion.',
  published: true
)

job_posting_95 = JobPosting.create(
  recruiter: recruiter_20,
  title: 'Customer Strategy Manager',
  company: 'ExxonMobil',
  skills: 'Customer strategy, Business planning, Market analysis, Strategic planning',
  description: 'Develop comprehensive customer-focused business strategies that align customer initiatives with business goals, drive customer-centric decision making, and create sustainable competitive advantages through strategic customer strategy development and implementation. You will be responsible for developing customer strategies, conducting market analysis, and creating strategic plans that align customer initiatives with overall business objectives and market opportunities. Your role will involve analyzing customer markets and competitive landscapes, developing customer strategy roadmaps, and coordinating customer initiatives across all business functions to ensure strategic alignment and successful execution. You will work closely with executive teams to align customer strategies with business objectives, collaborate with functional teams to implement customer initiatives, and contribute to our overall customer strategy and business planning processes. Additionally, you will stay current with customer strategy best practices and methodologies, implement new strategic planning tools and processes, and help establish our reputation for strong customer strategy and customer-centric business planning.',
  published: true
)

# Candidate 1
candidate_1 = Candidate.new(email: 'candidate_1@simplestresumes.com', password: password)
candidate_1.skip_confirmation!
candidate_1.save

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
  kind: :primary
)

SkillItem.create(
  resume: resume_1,
  name: 'Lead generation',
  kind: :primary
)

SkillItem.create(
  resume: resume_1,
  name: 'Sales growth',
  kind: :primary
)

SkillItem.create(
  resume: resume_1,
  name: 'Social media marketing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_1,
  name: 'Content marketing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_1,
  name: 'Digital marketing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_1,
  name: 'Email marketing',
  kind: :secondary
)

ExternalLinkItem.create(
  resume: resume_1,
  name: 'Linkedin',
  url: 'https://www.linkedin.com/'
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
  company: 'Google',
  location: 'Houston, TX',
  start_month: 4,
  start_year: 2018,
  description: 'Developed and implemented HR policies and procedures that ensured compliance with all applicable laws and regulations. During my time at Google, I was responsible for: Created high-quality content that was informative, engaging, and optimized for search engines. Provided excellent customer service, resolving issues quickly and efficiently. Developed and maintained web applications using Java, JavaScript, and HTML.'
)

WorkExperienceItem.create(
  resume: resume_1,
  position: 'Account Manager',
  company: 'Google',
  location: 'Philadelphia, PA',
  start_month: 3,
  start_year: 2014,
  end_month: 3,
  end_year: 2018,
  description: "Managed and grew the company's social media presence, increasing engagement and brand awareness. During my time at Google, I was responsible for: Created visually appealing and effective designs for a variety of marketing materials. Managed and grew the company's social media presence, increasing engagement and brand awareness. Created high-quality content that was informative, engaging, and optimized for search engines."
)

WorkExperienceItem.create(
  resume: resume_1,
  position: 'Project Manager',
  company: 'Google',
  location: 'San Diego, CA',
  start_month: 7,
  start_year: 2010,
  end_month: 2,
  end_year: 2014,
  description: 'Provided excellent customer service, resolving issues quickly and efficiently. During my time at Google, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Developed and implemented sales strategies that resulted in increased revenue. Created high-quality content that was informative, engaging, and optimized for search engines.'
)

# Candidate 2
candidate_2 = Candidate.new(email: 'candidate_2@simplestresumes.com', password: password)
candidate_2.skip_confirmation!
candidate_2.save

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
  kind: :primary
)

SkillItem.create(
  resume: resume_2,
  name: 'Python',
  kind: :primary
)

SkillItem.create(
  resume: resume_2,
  name: 'SQL',
  kind: :primary
)

SkillItem.create(
  resume: resume_2,
  name: 'HTML',
  kind: :secondary
)

SkillItem.create(
  resume: resume_2,
  name: 'CSS',
  kind: :secondary
)

SkillItem.create(
  resume: resume_2,
  name: 'Scrum',
  kind: :secondary
)

ExternalLinkItem.create(
  resume: resume_2,
  name: 'Linkedin',
  url: 'https://www.linkedin.com/'
)

ExternalLinkItem.create(
  resume: resume_2,
  name: 'Github',
  url: 'https://github.com/'
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
  company: 'Google',
  location: 'Philadelphia, PA',
  start_month: 3,
  start_year: 2021,
  description: "Managed and executed marketing campaigns that increased brand awareness and generated leads. During my time at Google, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Managed and executed projects from start to finish, ensuring they were completed on time and within budget. Created and executed marketing campaigns that supported the company's overall marketing strategy."
)

WorkExperienceItem.create(
  resume: resume_2,
  position: 'Social Media Manager',
  company: 'Google',
  location: 'Phoenix, AZ',
  start_month: 1,
  start_year: 2017,
  end_month: 2,
  end_year: 2021,
  description: 'Provided excellent customer service, resolving issues quickly and efficiently. During my time at Google, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Provided excellent customer service, resolving issues quickly and efficiently. Managed and executed marketing campaigns that increased brand awareness and generated leads.'
)

# Candidate 3
candidate_3 = Candidate.new(email: 'candidate_3@simplestresumes.com', password: password)
candidate_3.skip_confirmation!
candidate_3.save

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
  kind: :primary
)

SkillItem.create(
  resume: resume_3,
  name: 'InDesign',
  kind: :primary
)

SkillItem.create(
  resume: resume_3,
  name: 'Branding',
  kind: :primary
)

SkillItem.create(
  resume: resume_3,
  name: 'Marketing materials',
  kind: :secondary
)

SkillItem.create(
  resume: resume_3,
  name: 'User interface design',
  kind: :secondary
)

ExternalLinkItem.create(
  resume: resume_3,
  name: 'Github',
  url: 'https://github.com/'
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
  company: 'Google',
  location: 'Dallas, TX',
  start_month: 2,
  start_year: 2019,
  end_month: 9,
  end_year: 2023,
  description: "Managed and grew the company's social media presence, increasing engagement and brand awareness. During my time at Google, I was responsible for: Managed and grew the company's social media presence, increasing engagement and brand awareness. Created high-quality content that was informative, engaging, and optimized for search engines. Created visually appealing and effective designs for a variety of marketing materials."
)

WorkExperienceItem.create(
  resume: resume_3,
  position: 'Human Resources Manager',
  company: 'Google',
  location: 'Phoenix, AZ',
  start_month: 5,
  start_year: 2014,
  end_month: 1,
  end_year: 2019,
  description: 'Managed and executed marketing campaigns that increased brand awareness and generated leads. During my time at Google, I was responsible for: Created high-quality content that was informative, engaging, and optimized for search engines. Generated leads and closed deals, exceeding sales quotas consistently. Generated leads and closed deals, exceeding sales quotas consistently.'
)

WorkExperienceItem.create(
  resume: resume_3,
  position: 'Customer Service Representative',
  company: 'Google',
  location: 'Phoenix, AZ',
  start_month: 1,
  start_year: 2013,
  end_month: 4,
  end_year: 2014,
  description: 'Created high-quality content that was informative, engaging, and optimized for search engines. During my time at Google, I was responsible for: Developed and maintained web applications using Java, JavaScript, and HTML. Generated leads and closed deals, exceeding sales quotas consistently. Created visually appealing and effective designs for a variety of marketing materials.'
)

# Candidate 4
candidate_4 = Candidate.new(email: 'candidate_4@simplestresumes.com', password: password)
candidate_4.skip_confirmation!
candidate_4.save

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
  kind: :primary
)

SkillItem.create(
  resume: resume_4,
  name: 'Campaign development and execution',
  kind: :primary
)

SkillItem.create(
  resume: resume_4,
  name: 'Brand awareness',
  kind: :secondary
)

SkillItem.create(
  resume: resume_4,
  name: 'Public relations',
  kind: :secondary
)

ExternalLinkItem.create(
  resume: resume_4,
  name: 'Linkedin',
  url: 'https://www.linkedin.com/'
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
  company: 'Google',
  location: 'Jacksonville, FL',
  start_month: 2,
  start_year: 2023,
  description: "Created high-quality content that was informative, engaging, and optimized for search engines. During my time at Google, I was responsible for: Provided excellent customer service, resolving issues quickly and efficiently. Managed and grew the company's social media presence, increasing engagement and brand awareness. Developed and maintained websites that were user-friendly and met the needs of the business."
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

# Candidate 5
candidate_5 = Candidate.new(email: 'candidate_5@simplestresumes.com', password: password)
candidate_5.skip_confirmation!
candidate_5.save

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
  kind: :primary
)

SkillItem.create(
  resume: resume_5,
  name: 'React',
  kind: :primary
)

SkillItem.create(
  resume: resume_5,
  name: 'Javascript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_5,
  name: 'HTML',
  kind: :secondary
)

SkillItem.create(
  resume: resume_5,
  name: 'CSS',
  kind: :secondary
)

SkillItem.create(
  resume: resume_5,
  name: 'Git',
  kind: :secondary
)

ExternalLinkItem.create(
  resume: resume_5,
  name: 'Linkedin',
  url: 'https://www.linkedin.com/'
)

ExternalLinkItem.create(
  resume: resume_5,
  name: 'Github',
  url: 'https://github.com/'
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
  company: 'Amazon',
  location: 'Montevideo, Uruguay',
  start_month: 2,
  start_year: 2022,
  description: 'Since joining the team, I have continued to acquire knowledge in Ruby on Rails and at the same time I started to learn other technologies, including React, a frontend library, and Cucumber, a framework for behavior-driven development.'
)

WorkExperienceItem.create(
  resume: resume_5,
  position: 'Software Developer',
  company: 'Amazon',
  location: 'Montevideo, Uruguay',
  start_month: 10,
  start_year: 2019,
  end_month: 1,
  end_year: 2022,
  description: 'Worked as a full-stack developer using Ruby on Rails framework gaining experience in, within others, authentication and authorization systems, background jobs, scheduled tasks, ajax requests, third-party APIs integration, internationalization, mailers, data visualization, etc. Alongside RoR, I also gained experience with other languages, libraries and development tools such as HTML, CSS, JS, bootstrap, git, GitHub, SQL and Heroku. During this time, I have dealt with a variety of clients, spanning from small local companies to large multinational corporations using Agile/Scrum development techniques, staying in touch with clients daily, and reaching mutual agreements on ideas and next steps.'
)

WorkExperienceItem.create(
  resume: resume_5,
  position: 'Software Developer',
  company: 'Amazon',
  location: 'Montevideo, Uruguay',
  start_month: 2,
  start_year: 2013,
  end_month: 9,
  end_year: 2019,
  description: 'Planned preventive and corrective maintenance for the Coca-Cola products bottling company in Uruguay. Executed the maintenance management migration in SAP when the company ownership changed from The Coca-Cola Company to FEMSA. At this point, approximately 1,800 maintenance plans were redesigned.'
)

# Candidate 6
candidate_6 = Candidate.new(email: 'candidate_6@simplestresumes.com', password: password)
candidate_6.skip_confirmation!
candidate_6.save

resume_6 = Resume.create(
  candidate_id: candidate_6.id,
  name: 'Sarah Johnson',
  email: candidate_6.email,
  mobile: '+1 555 0006',
  location: 'San Francisco, CA',
  about_me: 'Passionate marketing professional with expertise in digital campaigns and brand strategy. I love creating compelling content that connects with audiences and drives business growth.'
)

EducationItem.create(
  resume_id: resume_6.id,
  name: 'Marketing Management',
  institute: 'Stanford University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_6.id,
  name: 'Digital Marketing Certification',
  institute: 'Google Digital Garage',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_6,
  name: 'Digital Marketing',
  kind: :primary
)

SkillItem.create(
  resume: resume_6,
  name: 'Content Creation',
  kind: :primary
)

SkillItem.create(
  resume: resume_6,
  name: 'Brand Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_6,
  name: 'Social Media Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_6,
  name: 'SEO',
  kind: :secondary
)

SkillItem.create(
  resume: resume_6,
  name: 'Analytics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_6,
  position: 'Senior Marketing Manager',
  company: 'Amazon',
  location: 'San Francisco, CA',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive digital marketing campaigns that increased brand awareness by 40% and generated over 500 qualified leads monthly. Managed a team of 8 marketing specialists, developed content strategies, and optimized campaigns across multiple channels including social media, email, and paid advertising. Implemented marketing automation tools that improved lead nurturing processes and increased conversion rates by 25%. Collaborated with sales teams to align marketing efforts with business objectives and ensure consistent messaging across all touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_6,
  position: 'Marketing Specialist',
  company: 'Amazon',
  location: 'Los Angeles, CA',
  start_month: 3,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Executed marketing campaigns and managed social media presence for multiple client accounts. Created engaging content that increased social media engagement by 60% and helped clients achieve their marketing goals. Conducted market research and competitor analysis to inform marketing strategies and identify new opportunities for growth.'
)

WorkExperienceItem.create(
  resume: resume_6,
  position: 'Marketing Intern',
  company: 'Startup Marketing Co',
  location: 'San Francisco, CA',
  start_month: 6,
  start_year: 2019,
  end_month: 8,
  end_year: 2019,
  description: 'Assisted marketing team with campaign execution and social media management. Created content for various marketing channels and supported event planning and execution. Gained hands-on experience with marketing tools and analytics platforms.'
)

ExternalLinkItem.create(
  resume: resume_6,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate6'
)

ExternalLinkItem.create(
  resume: resume_6,
  name: 'Portfolio',
  url: 'https://candidate6-portfolio.com'
)

ExternalLinkItem.create(
  resume: resume_6,
  name: 'Twitter',
  url: 'https://twitter.com/candidate6'
)

ReferenceItem.create(
  resume: resume_6,
  name: 'Michael Chen',
  position: 'Marketing Director',
  company: 'Digital Marketing Pro',
  mobile: '+1 555 0006',
  kind: :job
)

ReferenceItem.create(
  resume: resume_6,
  name: 'Lisa Rodriguez',
  position: 'Brand Manager',
  company: 'Brand Solutions Inc',
  mobile: '+1 555 0006',
  kind: :job
)

ReferenceItem.create(
  resume: resume_6,
  name: 'David Thompson',
  position: 'Marketing Consultant',
  company: 'Marketing Excellence',
  mobile: '+1 555 0006',
  kind: :personal
)

# Candidate 7
candidate_7 = Candidate.new(email: 'candidate_7@simplestresumes.com', password: password)
candidate_7.skip_confirmation!
candidate_7.save

resume_7 = Resume.create(
  candidate_id: candidate_7.id,
  name: 'Alex Rodriguez',
  email: candidate_7.email,
  mobile: '+1 555 0007',
  location: 'Seattle, WA',
  about_me: 'Experienced software engineer specializing in full-stack development and cloud architecture. I enjoy solving complex technical challenges and building scalable solutions that drive business innovation and user satisfaction.'
)

EducationItem.create(
  resume_id: resume_7.id,
  name: 'Computer Science',
  institute: 'University of Washington',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_7.id,
  name: 'AWS Solutions Architect',
  institute: 'Amazon Web Services',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_7,
  name: 'Full-Stack Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_7,
  name: 'Cloud Architecture',
  kind: :primary
)

SkillItem.create(
  resume: resume_7,
  name: 'React',
  kind: :primary
)

SkillItem.create(
  resume: resume_7,
  name: 'Node.js',
  kind: :secondary
)

SkillItem.create(
  resume: resume_7,
  name: 'Python',
  kind: :secondary
)

SkillItem.create(
  resume: resume_7,
  name: 'DevOps',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_7,
  position: 'Senior Software Engineer',
  company: 'Facebook',
  location: 'Seattle, WA',
  start_month: 6,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Developed and maintained scalable web applications using modern technologies including React, Node.js, and Python. Led the migration of legacy systems to cloud-based architecture, resulting in 30% improvement in performance and 50% reduction in infrastructure costs. Collaborated with cross-functional teams to design and implement new features, ensuring code quality and best practices. Mentored junior developers and conducted code reviews to maintain high coding standards and knowledge sharing within the team.'
)

WorkExperienceItem.create(
  resume: resume_7,
  position: 'Full-Stack Developer',
  company: 'Facebook',
  location: 'Seattle, WA',
  start_month: 1,
  start_year: 2019,
  end_month: 5,
  end_year: 2021,
  description: 'Built and maintained web applications for startup clients, working with technologies such as React, Node.js, and various databases. Implemented responsive designs and ensured cross-browser compatibility for all applications. Collaborated with designers and product managers to translate requirements into functional features.'
)

ExternalLinkItem.create(
  resume: resume_7,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate7'
)

ExternalLinkItem.create(
  resume: resume_7,
  name: 'GitHub',
  url: 'https://github.com/candidate7'
)

ReferenceItem.create(
  resume: resume_7,
  name: 'Sarah Kim',
  position: 'Engineering Manager',
  company: 'Tech Innovations Corp',
  mobile: '+1 555 0007',
  kind: :job
)

ReferenceItem.create(
  resume: resume_7,
  name: 'James Wilson',
  position: 'Senior Developer',
  company: 'Startup Solutions',
  mobile: '+1 555 0007',
  kind: :personal
)

# Candidate 8
candidate_8 = Candidate.new(email: 'candidate_8@simplestresumes.com', password: password)
candidate_8.skip_confirmation!
candidate_8.save

resume_8 = Resume.create(
  candidate_id: candidate_8.id,
  name: 'Emma Chen',
  email: candidate_8.email,
  mobile: '+1 555 0008',
  location: 'New York, NY',
  about_me: 'Creative graphic designer with a passion for visual storytelling and brand identity. I specialize in creating memorable designs that communicate effectively and leave lasting impressions on audiences.'
)

EducationItem.create(
  resume_id: resume_8.id,
  name: 'Graphic Design',
  institute: 'Parsons School of Design',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_8.id,
  name: 'Adobe Creative Suite Certification',
  institute: 'Adobe',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_8,
  name: 'Graphic Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_8,
  name: 'Brand Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_8,
  name: 'Adobe Creative Suite',
  kind: :primary
)

SkillItem.create(
  resume: resume_8,
  name: 'Typography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_8,
  name: 'Layout Design',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_8,
  position: 'Senior Graphic Designer',
  company: 'Facebook',
  location: 'New York, NY',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led creative direction for major brand campaigns and developed comprehensive brand identity systems for clients across various industries. Created visual assets including logos, marketing materials, packaging designs, and digital content that consistently elevated brand presence and improved customer engagement. Managed design projects from concept to completion, ensuring high-quality deliverables that met client objectives and brand guidelines.'
)

WorkExperienceItem.create(
  resume: resume_8,
  position: 'Graphic Designer',
  company: 'Facebook',
  location: 'New York, NY',
  start_month: 7,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Designed marketing materials, social media graphics, and print collateral for diverse client portfolios. Worked closely with art directors to develop creative concepts and ensure design consistency across all projects. Participated in client meetings to understand design requirements and present creative solutions.'
)

ExternalLinkItem.create(
  resume: resume_8,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate8'
)

ExternalLinkItem.create(
  resume: resume_8,
  name: 'Behance',
  url: 'https://behance.net/candidate8'
)

ExternalLinkItem.create(
  resume: resume_8,
  name: 'Portfolio',
  url: 'https://candidate8-portfolio.com'
)

ReferenceItem.create(
  resume: resume_8,
  name: 'Maria Garcia',
  position: 'Creative Director',
  company: 'Creative Design Studio',
  mobile: '+1 555 0008',
  kind: :job
)

ReferenceItem.create(
  resume: resume_8,
  name: 'Robert Johnson',
  position: 'Art Director',
  company: 'Visual Arts Agency',
  mobile: '+1 555 0008',
  kind: :personal
)

# Candidate 9
candidate_9 = Candidate.new(email: 'candidate_9@simplestresumes.com', password: password)
candidate_9.skip_confirmation!
candidate_9.save

resume_9 = Resume.create(
  candidate_id: candidate_9.id,
  name: 'Michael Thompson',
  email: candidate_9.email,
  mobile: '+1 555 0009',
  location: 'Chicago, IL',
  about_me: 'Results-driven sales professional with expertise in B2B sales and relationship building. I excel at understanding client needs and delivering solutions that drive business growth and create long-term partnerships.'
)

EducationItem.create(
  resume_id: resume_9.id,
  name: 'Business Administration',
  institute: 'University of Illinois',
  start_year: 2016,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_9.id,
  name: 'Sales Management Certification',
  institute: 'Sales Institute',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_9,
  name: 'B2B Sales',
  kind: :primary
)

SkillItem.create(
  resume: resume_9,
  name: 'Relationship Building',
  kind: :primary
)

SkillItem.create(
  resume: resume_9,
  name: 'Account Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_9,
  name: 'Sales Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_9,
  name: 'CRM',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_9,
  position: 'Senior Account Executive',
  company: 'Facebook',
  location: 'Chicago, IL',
  start_month: 9,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Managed a portfolio of enterprise clients with annual revenue exceeding $5M, consistently exceeding sales targets by 25% and maintaining 95% client retention rate. Developed and executed strategic account plans that identified growth opportunities and expanded client relationships. Built strong relationships with key decision-makers and stakeholders, positioning our solutions to address their business challenges and objectives.'
)

WorkExperienceItem.create(
  resume: resume_9,
  position: 'Sales Representative',
  company: 'Business Development Corp',
  location: 'Chicago, IL',
  start_month: 4,
  start_year: 2019,
  end_month: 8,
  end_year: 2021,
  description: 'Generated new business opportunities through prospecting, cold calling, and networking activities. Conducted product demonstrations and presentations to potential clients, effectively communicating value propositions and addressing client concerns. Managed the full sales cycle from lead generation to contract negotiation and closure.'
)

ExternalLinkItem.create(
  resume: resume_9,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate9'
)

ReferenceItem.create(
  resume: resume_9,
  name: 'Jennifer Davis',
  position: 'Sales Director',
  company: 'Enterprise Sales Solutions',
  mobile: '+1 555 0009',
  kind: :job
)

ReferenceItem.create(
  resume: resume_9,
  name: 'Christopher Lee',
  position: 'Business Development Manager',
  company: 'Business Development Corp',
  mobile: '+1 555 0009',
  kind: :personal
)

# Candidate 10
candidate_10 = Candidate.new(email: 'candidate_10@simplestresumes.com', password: password)
candidate_10.skip_confirmation!
candidate_10.save

resume_10 = Resume.create(
  candidate_id: candidate_10.id,
  name: 'Lisa Anderson',
  email: candidate_10.email,
  mobile: '+1 555 0010',
  location: 'Austin, TX',
  about_me: 'Dedicated human resources professional focused on employee development and organizational culture. I believe in creating positive workplace environments that foster growth, collaboration, and employee satisfaction while supporting business objectives.'
)

EducationItem.create(
  resume_id: resume_10.id,
  name: 'Human Resources Management',
  institute: 'University of Texas',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_10.id,
  name: 'SHRM Certification',
  institute: 'Society for Human Resource Management',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_10,
  name: 'HR Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_10,
  name: 'Employee Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_10,
  name: 'Recruitment',
  kind: :primary
)

SkillItem.create(
  resume: resume_10,
  name: 'Performance Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_10,
  name: 'HR Policies',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_10,
  position: 'HR Manager',
  company: 'Microsoft',
  location: 'Austin, TX',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive HR operations for a growing organization of 150+ employees, developing and implementing HR strategies that supported business objectives and employee satisfaction. Managed recruitment processes, employee development programs, and performance management systems that improved organizational effectiveness and employee engagement. Developed and maintained HR policies and procedures that ensured compliance with labor laws and best practices.'
)

WorkExperienceItem.create(
  resume: resume_10,
  position: 'HR Specialist',
  company: 'Microsoft',
  location: 'Austin, TX',
  start_month: 6,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Supported HR operations including recruitment, onboarding, and employee record management. Assisted with employee relations issues and provided support for HR initiatives and programs. Maintained HR databases and ensured accurate record keeping for all employee information.'
)

ExternalLinkItem.create(
  resume: resume_10,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate10'
)

ExternalLinkItem.create(
  resume: resume_10,
  name: 'SHRM Profile',
  url: 'https://shrm.org/members/candidate10'
)

ReferenceItem.create(
  resume: resume_10,
  name: 'Amanda White',
  position: 'HR Director',
  company: 'People First HR',
  mobile: '+1 555 0010',
  kind: :job
)

ReferenceItem.create(
  resume: resume_10,
  name: 'Daniel Brown',
  position: 'Talent Acquisition Manager',
  company: 'Talent Solutions',
  mobile: '+1 555 0010',
  kind: :personal
)

# Candidate 11
candidate_11 = Candidate.new(email: 'candidate_11@simplestresumes.com', password: password)
candidate_11.skip_confirmation!
candidate_11.save

resume_11 = Resume.create(
  candidate_id: candidate_11.id,
  name: 'David Kim',
  email: candidate_11.email,
  mobile: '+1 555 0011',
  location: 'Boston, MA',
  about_me: 'Analytical data scientist passionate about extracting insights from complex datasets. I enjoy transforming data into actionable business intelligence that drives strategic decision-making and organizational growth.'
)

EducationItem.create(
  resume_id: resume_11.id,
  name: 'Data Science',
  institute: 'MIT',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_11.id,
  name: 'Machine Learning Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_11,
  name: 'Data Science',
  kind: :primary
)

SkillItem.create(
  resume: resume_11,
  name: 'Machine Learning',
  kind: :primary
)

SkillItem.create(
  resume: resume_11,
  name: 'Python',
  kind: :primary
)

SkillItem.create(
  resume: resume_11,
  name: 'R',
  kind: :secondary
)

SkillItem.create(
  resume: resume_11,
  name: 'SQL',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_11,
  position: 'Senior Data Scientist',
  company: 'Microsoft',
  location: 'Boston, MA',
  start_month: 8,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led data science initiatives that delivered actionable insights and predictive models for business decision-making, resulting in 20% improvement in operational efficiency and 15% increase in revenue. Developed machine learning models for customer segmentation, churn prediction, and demand forecasting that supported strategic business planning. Collaborated with business stakeholders to understand data needs and translate complex analytical findings into clear, actionable recommendations.'
)

WorkExperienceItem.create(
  resume: resume_11,
  position: 'Data Analyst',
  company: 'Microsoft',
  location: 'Boston, MA',
  start_month: 11,
  start_year: 2019,
  end_month: 7,
  end_year: 2021,
  description: 'Analyzed business data to identify trends and patterns, creating reports and dashboards that supported decision-making processes. Conducted statistical analysis and developed data visualizations that effectively communicated insights to stakeholders. Collaborated with business teams to understand data requirements and ensure accurate analysis.'
)

ExternalLinkItem.create(
  resume: resume_11,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate11'
)

ExternalLinkItem.create(
  resume: resume_11,
  name: 'GitHub',
  url: 'https://github.com/candidate11'
)

ReferenceItem.create(
  resume: resume_11,
  name: 'Rachel Green',
  position: 'Data Science Director',
  company: 'Data Insights Lab',
  mobile: '+1 555 0011',
  kind: :job
)

ReferenceItem.create(
  resume: resume_11,
  name: 'Kevin Martinez',
  position: 'Senior Analyst',
  company: 'Analytics Solutions',
  mobile: '+1 555 0011',
  kind: :personal
)

# Candidate 12
candidate_12 = Candidate.new(email: 'candidate_12@simplestresumes.com', password: password)
candidate_12.skip_confirmation!
candidate_12.save

resume_12 = Resume.create(
  candidate_id: candidate_12.id,
  name: 'Sophie Williams',
  email: candidate_12.email,
  mobile: '+1 555 0012',
  location: 'Denver, CO',
  about_me: 'Innovative product manager with expertise in agile methodologies and user-centered design. I focus on delivering products that solve real problems and create meaningful user experiences.'
)

EducationItem.create(
  resume_id: resume_12.id,
  name: 'Product Management',
  institute: 'University of Colorado',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_12.id,
  name: 'Agile Scrum Master',
  institute: 'Scrum Alliance',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_12,
  name: 'Product Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_12,
  name: 'Agile Methodologies',
  kind: :primary
)

SkillItem.create(
  resume: resume_12,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_12,
  name: 'Product Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_12,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_12,
  position: 'Senior Product Manager',
  company: 'Microsoft',
  location: 'Denver, CO',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy and development for a portfolio of digital products serving over 100,000 users, resulting in 35% increase in user engagement and 25% improvement in customer satisfaction scores. Managed cross-functional product teams using agile methodologies, ensuring timely delivery of high-quality products that met user needs and business objectives. Conducted user research and market analysis to inform product decisions and prioritize feature development.'
)

WorkExperienceItem.create(
  resume: resume_12,
  position: 'Product Manager',
  company: 'Digital Products Inc',
  location: 'Denver, CO',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Managed product development lifecycle for multiple digital products, working with development teams to deliver features and improvements. Conducted user research and gathered feedback to inform product decisions and prioritize development efforts. Collaborated with stakeholders to define product requirements and ensure successful product launches.'
)

ExternalLinkItem.create(
  resume: resume_12,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate12'
)

ExternalLinkItem.create(
  resume: resume_12,
  name: 'Product Blog',
  url: 'https://candidate12-product-blog.com'
)

ReferenceItem.create(
  resume: resume_12,
  name: 'Jessica Taylor',
  position: 'VP of Product',
  company: 'Product Innovation Co',
  mobile: '+1 555 0012',
  kind: :job
)

ReferenceItem.create(
  resume: resume_12,
  name: 'Mark Johnson',
  position: 'Product Director',
  company: 'Digital Products Inc',
  mobile: '+1 555 0012',
  kind: :personal
)

# Candidate 13
candidate_13 = Candidate.new(email: 'candidate_13@simplestresumes.com', password: password)
candidate_13.skip_confirmation!
candidate_13.save

resume_13 = Resume.create(
  candidate_id: candidate_13.id,
  name: 'Ryan Davis',
  email: candidate_13.email,
  mobile: '+1 555 0013',
  location: 'Miami, FL',
  about_me: 'Strategic business analyst focused on process improvement and operational efficiency. I help organizations optimize their operations and achieve goals through data-driven insights and systematic improvements.'
)

EducationItem.create(
  resume_id: resume_13.id,
  name: 'Business Analysis',
  institute: 'University of Miami',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_13.id,
  name: 'Six Sigma Certification',
  institute: 'ASQ',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_13,
  name: 'Business Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_13,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_13,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_13,
  name: 'Requirements Gathering',
  kind: :secondary
)

SkillItem.create(
  resume: resume_13,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_13,
  position: 'Senior Business Analyst',
  company: 'The Home Depot',
  location: 'Miami, FL',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led business analysis initiatives that identified and implemented process improvements resulting in 30% reduction in operational costs and 40% improvement in process efficiency. Conducted comprehensive business process analysis and developed recommendations for optimization that supported organizational goals and improved customer experience. Managed stakeholder relationships and facilitated workshops to gather requirements and ensure alignment on business objectives.'
)

WorkExperienceItem.create(
  resume: resume_13,
  position: 'Business Analyst',
  company: 'The Home Depot',
  location: 'Miami, FL',
  start_month: 3,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Analyzed business processes and gathered requirements for system improvements and process optimization projects. Created business process documentation and worked with stakeholders to ensure accurate requirement definition. Supported project teams in implementing process improvements and system enhancements.'
)

ExternalLinkItem.create(
  resume: resume_13,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate13'
)

ReferenceItem.create(
  resume: resume_13,
  name: 'Amanda Rodriguez',
  position: 'Business Analysis Director',
  company: 'Business Optimization Group',
  mobile: '+1 555 0013',
  kind: :job
)

ReferenceItem.create(
  resume: resume_13,
  name: 'Carlos Mendez',
  position: 'Process Manager',
  company: 'Process Solutions',
  mobile: '+1 555 0013',
  kind: :personal
)

# Candidate 14
candidate_14 = Candidate.new(email: 'candidate_14@simplestresumes.com', password: password)
candidate_14.skip_confirmation!
candidate_14.save

resume_14 = Resume.create(
  candidate_id: candidate_14.id,
  name: 'Natalie Brown',
  email: candidate_14.email,
  mobile: '+1 555 0014',
  location: 'Portland, OR',
  about_me: 'Creative content strategist with expertise in storytelling and audience engagement. I develop content that connects with people and drives results through compelling narratives and strategic messaging.'
)

EducationItem.create(
  resume_id: resume_14.id,
  name: 'Communications',
  institute: 'Portland State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_14.id,
  name: 'Content Marketing Certification',
  institute: 'Content Marketing Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_14,
  name: 'Content Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_14,
  name: 'Content Creation',
  kind: :primary
)

SkillItem.create(
  resume: resume_14,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_14,
  name: 'Audience Engagement',
  kind: :secondary
)

SkillItem.create(
  resume: resume_14,
  name: 'SEO',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_14,
  position: 'Senior Content Strategist',
  company: 'The Home Depot',
  location: 'Portland, OR',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Developed and executed comprehensive content strategies that increased audience engagement by 50% and improved SEO rankings for key terms by 40%. Led content creation teams in developing high-quality, engaging content across multiple channels including blogs, social media, email campaigns, and video content. Conducted audience research and content performance analysis to optimize content strategies and improve engagement metrics.'
)

WorkExperienceItem.create(
  resume: resume_14,
  position: 'Content Strategist',
  company: 'The Home Depot',
  location: 'Portland, OR',
  start_month: 12,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Developed content strategies for client campaigns and managed content creation processes. Created engaging content for various platforms and conducted content performance analysis to optimize strategies. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_14,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate14'
)

ExternalLinkItem.create(
  resume: resume_14,
  name: 'Content Portfolio',
  url: 'https://candidate14-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_14,
  name: 'Sarah Wilson',
  position: 'Content Director',
  company: 'Content Strategy Pro',
  mobile: '+1 555 0014',
  kind: :job
)

ReferenceItem.create(
  resume: resume_14,
  name: 'Michael Chen',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0014',
  kind: :personal
)

# Candidate 15
candidate_15 = Candidate.new(email: 'candidate_15@simplestresumes.com', password: password)
candidate_15.skip_confirmation!
candidate_15.save

resume_15 = Resume.create(
  candidate_id: candidate_15.id,
  name: 'Andrew Wilson',
  email: candidate_15.email,
  mobile: '+1 555 0015',
  location: 'Nashville, TN',
  about_me: 'Experienced project manager with expertise in agile methodologies and team leadership. I deliver projects on time and within budget while building strong teams and fostering collaboration.'
)

EducationItem.create(
  resume_id: resume_15.id,
  name: 'Project Management',
  institute: 'Vanderbilt University',
  start_year: 2016,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_15.id,
  name: 'PMP Certification',
  institute: 'Project Management Institute',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_15,
  name: 'Project Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_15,
  name: 'Agile Methodologies',
  kind: :primary
)

SkillItem.create(
  resume: resume_15,
  name: 'Team Leadership',
  kind: :primary
)

SkillItem.create(
  resume: resume_15,
  name: 'Risk Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_15,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_15,
  position: 'Senior Project Manager',
  company: 'The Home Depot',
  location: 'Nashville, TN',
  start_month: 7,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led complex projects with budgets exceeding $2M, consistently delivering on time and within budget while maintaining high quality standards and stakeholder satisfaction. Managed cross-functional project teams of 15+ members, implementing agile methodologies that improved project delivery efficiency by 35%. Developed and maintained project plans, managed risks and issues, and ensured effective communication with all stakeholders throughout project lifecycles.'
)

WorkExperienceItem.create(
  resume: resume_15,
  position: 'Project Manager',
  company: 'Project Solutions',
  location: 'Nashville, TN',
  start_month: 10,
  start_year: 2019,
  end_month: 6,
  end_year: 2021,
  description: 'Managed multiple projects simultaneously, ensuring successful delivery within scope, budget, and timeline constraints. Coordinated with project teams and stakeholders to maintain project momentum and address challenges. Developed project documentation and maintained project schedules and budgets.'
)

ExternalLinkItem.create(
  resume: resume_15,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate15'
)

ReferenceItem.create(
  resume: resume_15,
  name: 'Jennifer Lee',
  position: 'Program Director',
  company: 'Project Excellence Corp',
  mobile: '+1 555 0015',
  kind: :job
)

ReferenceItem.create(
  resume: resume_15,
  name: 'Robert Smith',
  position: 'Senior PM',
  company: 'Project Solutions',
  mobile: '+1 555 0015',
  kind: :personal
)

# Candidate 16
candidate_16 = Candidate.new(email: 'candidate_16@simplestresumes.com', password: password)
candidate_16.skip_confirmation!
candidate_16.save

resume_16 = Resume.create(
  candidate_id: candidate_16.id,
  name: 'Emily Garcia',
  email: candidate_16.email,
  mobile: '+1 555 0016',
  location: 'San Diego, CA',
  about_me: 'Innovative UX designer focused on creating intuitive and engaging user experiences. I believe in user-centered design that solves real problems and delights users through thoughtful interaction design.'
)

EducationItem.create(
  resume_id: resume_16.id,
  name: 'User Experience Design',
  institute: 'UC San Diego',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_16.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_16,
  name: 'UX Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_16,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_16,
  name: 'Wireframing',
  kind: :primary
)

SkillItem.create(
  resume: resume_16,
  name: 'Prototyping',
  kind: :secondary
)

SkillItem.create(
  resume: resume_16,
  name: 'Usability Testing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_16,
  position: 'Senior UX Designer',
  company: 'Tesla',
  location: 'San Diego, CA',
  start_month: 2,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led UX design initiatives for digital products serving millions of users, resulting in 45% improvement in user satisfaction scores and 30% reduction in user support requests. Conducted comprehensive user research including interviews, surveys, and usability testing to inform design decisions and validate solutions. Developed user personas, journey maps, and design systems that ensured consistent and intuitive user experiences across all product touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_16,
  position: 'UX Designer',
  company: 'Tesla',
  location: 'San Diego, CA',
  start_month: 8,
  start_year: 2020,
  end_month: 1,
  end_year: 2022,
  description: 'Designed user interfaces and user experiences for web and mobile applications. Conducted user research and usability testing to inform design decisions. Created wireframes, prototypes, and design specifications for development teams.'
)

ExternalLinkItem.create(
  resume: resume_16,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate16'
)

ExternalLinkItem.create(
  resume: resume_16,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate16'
)

ReferenceItem.create(
  resume: resume_16,
  name: 'David Kim',
  position: 'UX Director',
  company: 'UX Design Studio',
  mobile: '+1 555 0016',
  kind: :job
)

ReferenceItem.create(
  resume: resume_16,
  name: 'Lisa Rodriguez',
  position: 'Design Manager',
  company: 'Digital Experience Lab',
  mobile: '+1 555 0016',
  kind: :personal
)

# Candidate 17
candidate_17 = Candidate.new(email: 'candidate_17@simplestresumes.com', password: password)
candidate_17.skip_confirmation!
candidate_17.save

resume_17 = Resume.create(
  candidate_id: candidate_17.id,
  name: 'James Martinez',
  email: candidate_17.email,
  mobile: '+1 555 0017',
  location: 'Phoenix, AZ',
  about_me: 'Strategic financial analyst with expertise in financial modeling and business intelligence. I help organizations make data-driven financial decisions that support growth and profitability objectives.'
)

EducationItem.create(
  resume_id: resume_17.id,
  name: 'Finance',
  institute: 'Arizona State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_17.id,
  name: 'CFA Level 1',
  institute: 'CFA Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_17,
  name: 'Financial Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_17,
  name: 'Financial Modeling',
  kind: :primary
)

SkillItem.create(
  resume: resume_17,
  name: 'Business Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_17,
  name: 'Budgeting',
  kind: :secondary
)

SkillItem.create(
  resume: resume_17,
  name: 'Forecasting',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_17,
  position: 'Senior Financial Analyst',
  company: 'Tesla',
  location: 'Phoenix, AZ',
  start_month: 11,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led financial analysis and reporting initiatives that provided critical insights for strategic decision-making, supporting business growth initiatives that increased revenue by 25% and improved profitability by 15%. Developed comprehensive financial models for business planning, investment analysis, and scenario planning that enabled informed decision-making by senior management. Conducted variance analysis and financial performance reviews that identified opportunities for cost optimization and revenue enhancement.'
)

WorkExperienceItem.create(
  resume: resume_17,
  position: 'Financial Analyst',
  company: 'Tesla',
  location: 'Phoenix, AZ',
  start_month: 1,
  start_year: 2020,
  end_month: 10,
  end_year: 2021,
  description: 'Analyzed financial data and prepared reports for management review and decision-making. Assisted with budget preparation and financial forecasting processes. Conducted financial research and supported financial planning initiatives.'
)

ExternalLinkItem.create(
  resume: resume_17,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate17'
)

ReferenceItem.create(
  resume: resume_17,
  name: 'Maria Gonzalez',
  position: 'Finance Director',
  company: 'Financial Intelligence Group',
  mobile: '+1 555 0017',
  kind: :job
)

ReferenceItem.create(
  resume: resume_17,
  name: 'John Anderson',
  position: 'Senior Analyst',
  company: 'Financial Solutions Inc',
  mobile: '+1 555 0017',
  kind: :personal
)

# Candidate 18
candidate_18 = Candidate.new(email: 'candidate_18@simplestresumes.com', password: password)
candidate_18.skip_confirmation!
candidate_18.save

resume_18 = Resume.create(
  candidate_id: candidate_18.id,
  name: 'Ashley Taylor',
  email: candidate_18.email,
  mobile: '+1 555 0018',
  location: 'Atlanta, GA',
  about_me: 'Creative marketing strategist with expertise in brand development and campaign management. I build brands that connect with audiences and drive growth through innovative marketing approaches.'
)

EducationItem.create(
  resume_id: resume_18.id,
  name: 'Marketing',
  institute: 'Georgia Tech',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_18.id,
  name: 'Digital Marketing Certification',
  institute: 'HubSpot Academy',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_18,
  name: 'Marketing Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_18,
  name: 'Brand Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_18,
  name: 'Campaign Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_18,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_18,
  name: 'Creative Direction',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_18,
  position: 'Senior Marketing Strategist',
  company: 'Tesla',
  location: 'Atlanta, GA',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Developed and executed comprehensive marketing strategies that increased brand awareness by 60% and generated over 1,000 qualified leads monthly across multiple channels. Led brand development initiatives including brand positioning, messaging development, and visual identity creation that differentiated clients in competitive markets. Managed integrated marketing campaigns from concept to execution, ensuring consistent messaging and optimal performance across all touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_18,
  position: 'Marketing Strategist',
  company: 'Marketing Solutions Pro',
  location: 'Atlanta, GA',
  start_month: 6,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Developed marketing strategies for client campaigns and managed marketing initiatives across various channels. Conducted market research and competitive analysis to inform marketing decisions. Collaborated with creative teams to develop marketing materials and ensure brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_18,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate18'
)

ExternalLinkItem.create(
  resume: resume_18,
  name: 'Marketing Blog',
  url: 'https://candidate18-marketing-blog.com'
)

ReferenceItem.create(
  resume: resume_18,
  name: 'Christopher Lee',
  position: 'Marketing Director',
  company: 'Strategic Marketing Group',
  mobile: '+1 555 0018',
  kind: :job
)

ReferenceItem.create(
  resume: resume_18,
  name: 'Jennifer Davis',
  position: 'Brand Manager',
  company: 'Marketing Solutions Pro',
  mobile: '+1 555 0018',
  kind: :personal
)

# Candidate 19
candidate_19 = Candidate.new(email: 'candidate_19@simplestresumes.com', password: password)
candidate_19.skip_confirmation!
candidate_19.save

resume_19 = Resume.create(
  candidate_id: candidate_19.id,
  name: 'Brandon Johnson',
  email: candidate_19.email,
  mobile: '+1 555 0019',
  location: 'Las Vegas, NV',
  about_me: 'Experienced operations manager focused on process optimization and team efficiency. I streamline operations to improve productivity and reduce costs while maintaining high quality standards.'
)

EducationItem.create(
  resume_id: resume_19.id,
  name: 'Operations Management',
  institute: 'University of Nevada',
  start_year: 2016,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_19.id,
  name: 'Lean Six Sigma Certification',
  institute: 'ASQ',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_19,
  name: 'Operations Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_19,
  name: 'Process Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_19,
  name: 'Team Leadership',
  kind: :primary
)

SkillItem.create(
  resume: resume_19,
  name: 'Performance Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_19,
  name: 'Supply Chain',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_19,
  position: 'Senior Operations Manager',
  company: 'Palantir',
  location: 'Las Vegas, NV',
  start_month: 9,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led operations for a multi-site organization with 200+ employees, implementing process improvements that increased operational efficiency by 40% and reduced costs by 25% while maintaining high quality standards. Managed cross-functional operations teams, developed performance metrics and KPIs, and implemented continuous improvement initiatives that enhanced productivity and customer satisfaction. Optimized supply chain processes and vendor relationships, resulting in improved delivery times and reduced operational costs.'
)

WorkExperienceItem.create(
  resume: resume_19,
  position: 'Operations Manager',
  company: 'Palantir',
  location: 'Las Vegas, NV',
  start_month: 3,
  start_year: 2020,
  end_month: 8,
  end_year: 2021,
  description: 'Managed daily operations and supervised operational teams to ensure efficient and effective service delivery. Implemented process improvements and quality control measures. Coordinated with other departments to optimize operational workflows and address operational challenges.'
)

ExternalLinkItem.create(
  resume: resume_19,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate19'
)

ReferenceItem.create(
  resume: resume_19,
  name: 'Sarah Wilson',
  position: 'Operations Director',
  company: 'Operations Excellence Corp',
  mobile: '+1 555 0019',
  kind: :job
)

ReferenceItem.create(
  resume: resume_19,
  name: 'Michael Brown',
  position: 'Process Manager',
  company: 'Process Optimization Inc',
  mobile: '+1 555 0019',
  kind: :personal
)

# Candidate 20
candidate_20 = Candidate.new(email: 'candidate_20@simplestresumes.com', password: password)
candidate_20.skip_confirmation!
candidate_20.save

resume_20 = Resume.create(
  candidate_id: candidate_20.id,
  name: 'Rachel Green',
  email: candidate_20.email,
  mobile: '+1 555 0020',
  location: 'Orlando, FL',
  about_me: 'Innovative business development professional with expertise in market expansion and partnership development. I identify opportunities and build strategic relationships that drive business growth and market presence.'
)

EducationItem.create(
  resume_id: resume_20.id,
  name: 'Business Development',
  institute: 'University of Central Florida',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_20.id,
  name: 'Strategic Partnerships Certification',
  institute: 'Business Development Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_20,
  name: 'Business Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_20,
  name: 'Market Expansion',
  kind: :primary
)

SkillItem.create(
  resume: resume_20,
  name: 'Partnership Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_20,
  name: 'Strategic Planning',
  kind: :secondary
)

SkillItem.create(
  resume: resume_20,
  name: 'Relationship Building',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_20,
  position: 'Senior Business Development Manager',
  company: 'Palantir',
  location: 'Orlando, FL',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business development initiatives that expanded market presence into 5 new territories and established strategic partnerships that generated $10M in additional revenue. Developed and executed market expansion strategies that identified new opportunities and positioned the company for sustainable growth in emerging markets. Built and maintained relationships with key partners, clients, and stakeholders that supported business objectives and created new revenue streams.'
)

WorkExperienceItem.create(
  resume: resume_20,
  position: 'Business Development Manager',
  company: 'Palantir',
  location: 'Orlando, FL',
  start_month: 7,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Identified new business opportunities and developed strategies for market expansion and growth. Built relationships with potential partners and clients to support business development objectives. Conducted market research and analysis to inform business development strategies.'
)

ExternalLinkItem.create(
  resume: resume_20,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate20'
)

ReferenceItem.create(
  resume: resume_20,
  name: 'David Thompson',
  position: 'Business Development Director',
  company: 'Business Growth Partners',
  mobile: '+1 555 0020',
  kind: :job
)

ReferenceItem.create(
  resume: resume_20,
  name: 'Lisa Anderson',
  position: 'Partnership Manager',
  company: 'Strategic Partnerships Inc',
  mobile: '+1 555 0020',
  kind: :personal
)

# Candidate 21
candidate_21 = Candidate.new(email: 'candidate_21@simplestresumes.com', password: password)
candidate_21.skip_confirmation!
candidate_21.save

resume_21 = Resume.create(
  candidate_id: candidate_21.id,
  name: 'Kevin Lee',
  email: candidate_21.email,
  mobile: '+1 555 0021',
  location: 'Minneapolis, MN',
  about_me: 'Creative digital artist with expertise in 3D modeling and visual effects. I bring imagination to life through innovative digital design and animation that captivates audiences.'
)

EducationItem.create(
  resume_id: resume_21.id,
  name: 'Digital Arts',
  institute: 'Minneapolis College of Art and Design',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_21.id,
  name: '3D Animation Certification',
  institute: 'Autodesk',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_21,
  name: '3D Modeling',
  kind: :primary
)

SkillItem.create(
  resume: resume_21,
  name: 'Visual Effects',
  kind: :primary
)

SkillItem.create(
  resume: resume_21,
  name: 'Digital Animation',
  kind: :primary
)

SkillItem.create(
  resume: resume_21,
  name: 'Maya',
  kind: :secondary
)

SkillItem.create(
  resume: resume_21,
  name: 'Blender',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_21,
  position: 'Senior 3D Artist',
  company: 'Palantir',
  location: 'Minneapolis, MN',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led 3D modeling and visual effects projects for major entertainment and advertising clients, creating high-quality assets that enhanced visual storytelling and brand engagement. Developed and maintained 3D asset libraries and workflows that improved production efficiency and ensured consistent quality across all projects. Collaborated with creative directors and production teams to translate concepts into compelling 3D visualizations and animations.'
)

WorkExperienceItem.create(
  resume: resume_21,
  position: '3D Artist',
  company: 'Creative Visual Effects',
  location: 'Minneapolis, MN',
  start_month: 4,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Created 3D models and visual effects for various projects including games, films, and advertising campaigns. Worked with creative teams to develop visual concepts and ensure technical feasibility. Maintained 3D asset libraries and supported production workflows.'
)

ExternalLinkItem.create(
  resume: resume_21,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate21'
)

ExternalLinkItem.create(
  resume: resume_21,
  name: 'ArtStation',
  url: 'https://artstation.com/candidate21'
)

ReferenceItem.create(
  resume: resume_21,
  name: 'Jessica Kim',
  position: 'Creative Director',
  company: 'Digital Arts Studio',
  mobile: '+1 555 0021',
  kind: :job
)

ReferenceItem.create(
  resume: resume_21,
  name: 'Alex Rodriguez',
  position: 'VFX Supervisor',
  company: 'Creative Visual Effects',
  mobile: '+1 555 0021',
  kind: :personal
)

# Candidate 22
candidate_22 = Candidate.new(email: 'candidate_22@simplestresumes.com', password: password)
candidate_22.skip_confirmation!
candidate_22.save

resume_22 = Resume.create(
  candidate_id: candidate_22.id,
  name: 'Maria Gonzalez',
  email: candidate_22.email,
  mobile: '+1 555 0022',
  location: 'San Antonio, TX',
  about_me: 'Strategic supply chain professional with expertise in logistics optimization and vendor management. I streamline supply chains to improve efficiency and reduce costs while maintaining quality standards.'
)

EducationItem.create(
  resume_id: resume_22.id,
  name: 'Supply Chain Management',
  institute: 'University of Texas at San Antonio',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_22.id,
  name: 'CPSM Certification',
  institute: 'ISM',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_22,
  name: 'Supply Chain Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_22,
  name: 'Logistics Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_22,
  name: 'Vendor Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_22,
  name: 'Inventory Control',
  kind: :secondary
)

SkillItem.create(
  resume: resume_22,
  name: 'Cost Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_22,
  position: 'Senior Supply Chain Manager',
  company: 'Nvidia',
  location: 'San Antonio, TX',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led supply chain operations for a global organization with operations in 15 countries, implementing optimization strategies that reduced logistics costs by 30% and improved delivery performance by 45%. Managed relationships with 200+ vendors and suppliers, developing strategic partnerships that improved service levels and reduced supply chain risks. Implemented inventory management systems and demand forecasting processes that optimized stock levels and reduced carrying costs while maintaining high service levels.'
)

WorkExperienceItem.create(
  resume: resume_22,
  position: 'Supply Chain Manager',
  company: 'Nvidia',
  location: 'San Antonio, TX',
  start_month: 9,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Managed supply chain operations and vendor relationships to ensure efficient and cost-effective supply chain performance. Implemented inventory management systems and optimized logistics processes. Coordinated with suppliers and logistics providers to maintain supply chain efficiency.'
)

ExternalLinkItem.create(
  resume: resume_22,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate22'
)

ReferenceItem.create(
  resume: resume_22,
  name: 'Carlos Mendez',
  position: 'Supply Chain Director',
  company: 'Supply Chain Solutions',
  mobile: '+1 555 0022',
  kind: :job
)

ReferenceItem.create(
  resume: resume_22,
  name: 'Ana Rodriguez',
  position: 'Logistics Manager',
  company: 'Logistics Optimization Inc',
  mobile: '+1 555 0022',
  kind: :personal
)

# Candidate 23
candidate_23 = Candidate.new(email: 'candidate_23@simplestresumes.com', password: password)
candidate_23.skip_confirmation!
candidate_23.save

resume_23 = Resume.create(
  candidate_id: candidate_23.id,
  name: 'Daniel Wilson',
  email: candidate_23.email,
  mobile: '+1 555 0023',
  location: 'Detroit, MI',
  about_me: 'Innovative research analyst with expertise in market research and competitive intelligence. I provide insights that drive strategic decision-making and help organizations understand their markets.'
)

EducationItem.create(
  resume_id: resume_23.id,
  name: 'Market Research',
  institute: 'University of Michigan',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_23.id,
  name: 'Competitive Intelligence Certification',
  institute: 'SCIP',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_23,
  name: 'Market Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_23,
  name: 'Competitive Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_23,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_23,
  name: 'Strategic Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_23,
  name: 'Report Writing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_23,
  position: 'Senior Research Analyst',
  company: 'Nvidia',
  location: 'Detroit, MI',
  start_month: 10,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive market research and competitive intelligence initiatives that provided critical insights for strategic planning, supporting business decisions that increased market share by 20% and improved competitive positioning. Conducted primary and secondary research including surveys, interviews, and market analysis that identified market opportunities and competitive threats. Developed competitive intelligence frameworks and monitoring systems that provided ongoing insights into competitor activities and market trends.'
)

WorkExperienceItem.create(
  resume: resume_23,
  position: 'Research Analyst',
  company: 'Nvidia',
  location: 'Detroit, MI',
  start_month: 2,
  start_year: 2020,
  end_month: 9,
  end_year: 2021,
  description: 'Conducted market research and competitive analysis to support business decision-making and strategic planning. Collected and analyzed data from various sources to identify market trends and opportunities. Prepared research reports and presentations for stakeholders.'
)

ExternalLinkItem.create(
  resume: resume_23,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate23'
)

ReferenceItem.create(
  resume: resume_23,
  name: 'Sarah Johnson',
  position: 'Research Director',
  company: 'Market Intelligence Group',
  mobile: '+1 555 0023',
  kind: :job
)

ReferenceItem.create(
  resume: resume_23,
  name: 'Michael Brown',
  position: 'Senior Analyst',
  company: 'Research Solutions Pro',
  mobile: '+1 555 0023',
  kind: :personal
)

# Candidate 24
candidate_24 = Candidate.new(email: 'candidate_24@simplestresumes.com', password: password)
candidate_24.skip_confirmation!
candidate_24.save

resume_24 = Resume.create(
  candidate_id: candidate_24.id,
  name: 'Amanda Davis',
  email: candidate_24.email,
  mobile: '+1 555 0024',
  location: 'Charlotte, NC',
  about_me: 'Creative video producer with expertise in storytelling and visual production. I create compelling video content that engages audiences and drives results through innovative storytelling techniques.'
)

EducationItem.create(
  resume_id: resume_24.id,
  name: 'Film Production',
  institute: 'University of North Carolina',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_24.id,
  name: 'Video Production Certification',
  institute: 'Adobe',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_24,
  name: 'Video Production',
  kind: :primary
)

SkillItem.create(
  resume: resume_24,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_24,
  name: 'Video Editing',
  kind: :primary
)

SkillItem.create(
  resume: resume_24,
  name: 'Cinematography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_24,
  name: 'Post-Production',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_24,
  position: 'Senior Video Producer',
  company: 'Nvidia',
  location: 'Charlotte, NC',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led video production projects for major brands and entertainment clients, creating compelling content that increased audience engagement by 55% and improved brand awareness across multiple platforms. Developed creative concepts and production strategies that aligned with client objectives and target audience preferences. Managed production teams and coordinated all aspects of video production from pre-production planning to final delivery.'
)

WorkExperienceItem.create(
  resume: resume_24,
  position: 'Video Producer',
  company: 'Digital Video Studio',
  location: 'Charlotte, NC',
  start_month: 8,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Produced video content for various clients and platforms, managing production processes from concept to final delivery. Coordinated with creative teams and clients to develop video concepts and ensure successful production outcomes. Managed production schedules and budgets.'
)

ExternalLinkItem.create(
  resume: resume_24,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate24'
)

ExternalLinkItem.create(
  resume: resume_24,
  name: 'Vimeo',
  url: 'https://vimeo.com/candidate24'
)

ReferenceItem.create(
  resume: resume_24,
  name: 'Robert Johnson',
  position: 'Production Director',
  company: 'Creative Video Productions',
  mobile: '+1 555 0024',
  kind: :job
)

ReferenceItem.create(
  resume: resume_24,
  name: 'Lisa Chen',
  position: 'Creative Director',
  company: 'Digital Video Studio',
  mobile: '+1 555 0024',
  kind: :personal
)

# Candidate 25
candidate_25 = Candidate.new(email: 'candidate_25@simplestresumes.com', password: password)
candidate_25.skip_confirmation!
candidate_25.save

resume_25 = Resume.create(
  candidate_id: candidate_25.id,
  name: 'Christopher Lee',
  email: candidate_25.email,
  mobile: '+1 555 0025',
  location: 'Kansas City, MO',
  about_me: 'Strategic communications professional with expertise in public relations and media relations. I build strong relationships and manage brand reputation through effective communication strategies.'
)

EducationItem.create(
  resume_id: resume_25.id,
  name: 'Communications',
  institute: 'University of Missouri',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_25.id,
  name: 'PR Certification',
  institute: 'PRSA',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_25,
  name: 'Public Relations',
  kind: :primary
)

SkillItem.create(
  resume: resume_25,
  name: 'Media Relations',
  kind: :primary
)

SkillItem.create(
  resume: resume_25,
  name: 'Crisis Communications',
  kind: :primary
)

SkillItem.create(
  resume: resume_25,
  name: 'Brand Reputation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_25,
  name: 'Strategic Communications',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_25,
  position: 'Senior Communications Manager',
  company: 'Apple',
  location: 'Kansas City, MO',
  start_month: 11,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive communications strategies for high-profile organizations, managing media relations and public communications that enhanced brand reputation and maintained positive public perception during challenging situations. Developed and executed crisis communications plans that protected brand reputation and maintained stakeholder confidence during critical incidents. Built and maintained relationships with key media contacts and stakeholders, ensuring effective communication of organizational messages and initiatives.'
)

WorkExperienceItem.create(
  resume: resume_25,
  position: 'Communications Manager',
  company: 'Apple',
  location: 'Kansas City, MO',
  start_month: 5,
  start_year: 2020,
  end_month: 10,
  end_year: 2021,
  description: 'Managed communications strategies and media relations for client organizations. Developed press releases and communications materials. Coordinated with media contacts and stakeholders to ensure effective message delivery and brand positioning.'
)

ExternalLinkItem.create(
  resume: resume_25,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate25'
)

ReferenceItem.create(
  resume: resume_25,
  name: 'Jennifer Smith',
  position: 'Communications Director',
  company: 'Strategic Communications Group',
  mobile: '+1 555 0025',
  kind: :job
)

ReferenceItem.create(
  resume: resume_25,
  name: 'David Wilson',
  position: 'PR Manager',
  company: 'Public Relations Pro',
  mobile: '+1 555 0025',
  kind: :personal
)

# Candidate 26
candidate_26 = Candidate.new(email: 'candidate_26@simplestresumes.com', password: password)
candidate_26.skip_confirmation!
candidate_26.save

resume_26 = Resume.create(
  candidate_id: candidate_26.id,
  name: 'Stephanie Brown',
  email: candidate_26.email,
  mobile: '+1 555 0026',
  location: 'Columbus, OH',
  about_me: 'Experienced customer success manager with expertise in relationship building and client retention. I focus on ensuring customer satisfaction and driving long-term business relationships.'
)

EducationItem.create(
  resume_id: resume_26.id,
  name: 'Business Administration',
  institute: 'Ohio State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_26.id,
  name: 'Customer Success Certification',
  institute: 'Gainsight',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_26,
  name: 'Customer Success',
  kind: :primary
)

SkillItem.create(
  resume: resume_26,
  name: 'Relationship Building',
  kind: :primary
)

SkillItem.create(
  resume: resume_26,
  name: 'Client Retention',
  kind: :primary
)

SkillItem.create(
  resume: resume_26,
  name: 'Account Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_26,
  name: 'Customer Onboarding',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_26,
  position: 'Senior Customer Success Manager',
  company: 'Apple',
  location: 'Columbus, OH',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led customer success initiatives for a portfolio of enterprise clients, achieving 95% customer retention rate and 40% increase in customer lifetime value. Developed and implemented customer success strategies that improved customer satisfaction scores and reduced churn rates. Managed relationships with key accounts, ensuring successful product adoption and identifying opportunities for expansion and growth.'
)

WorkExperienceItem.create(
  resume: resume_26,
  position: 'Customer Success Manager',
  company: 'Apple',
  location: 'Columbus, OH',
  start_month: 7,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Managed customer relationships and ensured successful product adoption for mid-market clients. Conducted regular check-ins and provided product training and support. Identified opportunities for customer expansion and worked with sales teams to drive growth.'
)

ExternalLinkItem.create(
  resume: resume_26,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate26'
)

ReferenceItem.create(
  resume: resume_26,
  name: 'Mark Johnson',
  position: 'Customer Success Director',
  company: 'Customer Success Pro',
  mobile: '+1 555 0026',
  kind: :job
)

ReferenceItem.create(
  resume: resume_26,
  name: 'Sarah Williams',
  position: 'Client Success Manager',
  company: 'Client Success Solutions',
  mobile: '+1 555 0026',
  kind: :personal
)

# Candidate 27
candidate_27 = Candidate.new(email: 'candidate_27@simplestresumes.com', password: password)
candidate_27.skip_confirmation!
candidate_27.save

resume_27 = Resume.create(
  candidate_id: candidate_27.id,
  name: 'Jonathan Taylor',
  email: candidate_27.email,
  mobile: '+1 555 0027',
  location: 'Indianapolis, IN',
  about_me: 'Innovative business intelligence analyst with expertise in data visualization and reporting. I transform complex data into actionable insights that support strategic decision-making.'
)

EducationItem.create(
  resume_id: resume_27.id,
  name: 'Business Intelligence',
  institute: 'Indiana University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_27.id,
  name: 'Tableau Certification',
  institute: 'Tableau',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_27,
  name: 'Business Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_27,
  name: 'Data Visualization',
  kind: :primary
)

SkillItem.create(
  resume: resume_27,
  name: 'Reporting',
  kind: :primary
)

SkillItem.create(
  resume: resume_27,
  name: 'SQL',
  kind: :secondary
)

SkillItem.create(
  resume: resume_27,
  name: 'Power BI',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_27,
  position: 'Senior Business Intelligence Analyst',
  company: 'Apple',
  location: 'Indianapolis, IN',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business intelligence initiatives that delivered actionable insights and improved decision-making processes, resulting in 25% improvement in operational efficiency and 20% increase in revenue. Developed comprehensive dashboards and reports that provided real-time visibility into business performance and key metrics. Collaborated with business stakeholders to understand reporting needs and develop solutions that supported strategic objectives.'
)

WorkExperienceItem.create(
  resume: resume_27,
  position: 'Business Intelligence Analyst',
  company: 'Data Insights Pro',
  location: 'Indianapolis, IN',
  start_month: 9,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Analyzed business data and created reports and dashboards to support decision-making processes. Developed data visualizations and worked with stakeholders to understand reporting requirements. Maintained data quality and ensured accurate reporting across all business functions.'
)

ExternalLinkItem.create(
  resume: resume_27,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate27'
)

ExternalLinkItem.create(
  resume: resume_27,
  name: 'Tableau Public',
  url: 'https://public.tableau.com/profile/candidate27'
)

ReferenceItem.create(
  resume: resume_27,
  name: 'Amanda Rodriguez',
  position: 'BI Director',
  company: 'BI Solutions Group',
  mobile: '+1 555 0027',
  kind: :job
)

ReferenceItem.create(
  resume: resume_27,
  name: 'Michael Chen',
  position: 'Senior Analyst',
  company: 'Data Insights Pro',
  mobile: '+1 555 0027',
  kind: :personal
)

# Candidate 28
candidate_28 = Candidate.new(email: 'candidate_28@simplestresumes.com', password: password)
candidate_28.skip_confirmation!
candidate_28.save

resume_28 = Resume.create(
  candidate_id: candidate_28.id,
  name: 'Nicole Anderson',
  email: candidate_28.email,
  mobile: '+1 555 0028',
  location: 'Seattle, WA',
  about_me: 'Creative brand strategist with expertise in brand positioning and identity development. I build memorable brands that connect with audiences and drive business growth through strategic brand initiatives.'
)

EducationItem.create(
  resume_id: resume_28.id,
  name: 'Brand Strategy',
  institute: 'University of Washington',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_28.id,
  name: 'Brand Management Certification',
  institute: 'AMA',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_28,
  name: 'Brand Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_28,
  name: 'Brand Positioning',
  kind: :primary
)

SkillItem.create(
  resume: resume_28,
  name: 'Identity Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_28,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_28,
  name: 'Creative Direction',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_28,
  position: 'Senior Brand Strategist',
  company: 'Shopify',
  location: 'Seattle, WA',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led brand strategy initiatives for major clients across various industries, developing comprehensive brand positioning and identity systems that increased brand awareness by 50% and improved customer engagement. Conducted market research and competitive analysis to inform brand strategies and identify differentiation opportunities. Collaborated with creative teams to develop brand identities and ensure consistent brand expression across all touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_28,
  position: 'Brand Strategist',
  company: 'Shopify',
  location: 'Seattle, WA',
  start_month: 12,
  start_year: 2020,
  end_month: 7,
  end_year: 2022,
  description: 'Developed brand strategies for client campaigns and managed brand development processes. Conducted brand research and competitive analysis to inform strategic decisions. Worked with creative teams to develop brand identities and ensure brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_28,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate28'
)

ExternalLinkItem.create(
  resume: resume_28,
  name: 'Brand Portfolio',
  url: 'https://candidate28-brand-portfolio.com'
)

ReferenceItem.create(
  resume: resume_28,
  name: 'David Kim',
  position: 'Brand Director',
  company: 'Brand Strategy Group',
  mobile: '+1 555 0028',
  kind: :job
)

ReferenceItem.create(
  resume: resume_28,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Brand Solutions',
  mobile: '+1 555 0028',
  kind: :personal
)

# Candidate 29
candidate_29 = Candidate.new(email: 'candidate_29@simplestresumes.com', password: password)
candidate_29.skip_confirmation!
candidate_29.save

resume_29 = Resume.create(
  candidate_id: candidate_29.id,
  name: 'Robert Smith',
  email: candidate_29.email,
  mobile: '+1 555 0029',
  location: 'Denver, CO',
  about_me: 'Strategic innovation manager with expertise in product development and market research. I drive innovation initiatives that create competitive advantages and deliver value to customers.'
)

EducationItem.create(
  resume_id: resume_29.id,
  name: 'Innovation Management',
  institute: 'University of Colorado',
  start_year: 2016,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_29.id,
  name: 'Innovation Strategy Certification',
  institute: 'IDEO',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_29,
  name: 'Innovation Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_29,
  name: 'Product Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_29,
  name: 'Market Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_29,
  name: 'Strategic Planning',
  kind: :secondary
)

SkillItem.create(
  resume: resume_29,
  name: 'Design Thinking',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_29,
  position: 'Senior Innovation Manager',
  company: 'Shopify',
  location: 'Denver, CO',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led innovation initiatives that resulted in 5 new product launches and 30% increase in market share within target segments. Managed cross-functional innovation teams and implemented design thinking methodologies that improved product development processes and customer satisfaction. Conducted market research and competitive analysis to identify innovation opportunities and develop strategic innovation roadmaps.'
)

WorkExperienceItem.create(
  resume: resume_29,
  position: 'Innovation Manager',
  company: 'Shopify',
  location: 'Denver, CO',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Managed innovation projects and product development initiatives for various clients. Conducted market research and competitive analysis to inform innovation strategies. Collaborated with design and engineering teams to develop innovative solutions.'
)

ExternalLinkItem.create(
  resume: resume_29,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate29'
)

ReferenceItem.create(
  resume: resume_29,
  name: 'Jennifer Wilson',
  position: 'Innovation Director',
  company: 'Innovation Solutions Corp',
  mobile: '+1 555 0029',
  kind: :job
)

ReferenceItem.create(
  resume: resume_29,
  name: 'Michael Brown',
  position: 'Product Manager',
  company: 'Creative Innovation Lab',
  mobile: '+1 555 0029',
  kind: :personal
)

# Candidate 30
candidate_30 = Candidate.new(email: 'candidate_30@simplestresumes.com', password: password)
candidate_30.skip_confirmation!
candidate_30.save

resume_30 = Resume.create(
  candidate_id: candidate_30.id,
  name: 'Jessica Martinez',
  email: candidate_30.email,
  mobile: '+1 555 0030',
  location: 'Austin, TX',
  about_me: 'Experienced quality assurance manager with expertise in process improvement and compliance management. I ensure high quality standards and continuous improvement across all organizational processes.'
)

EducationItem.create(
  resume_id: resume_30.id,
  name: 'Quality Management',
  institute: 'University of Texas',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_30.id,
  name: 'Six Sigma Black Belt',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_30,
  name: 'Quality Assurance',
  kind: :primary
)

SkillItem.create(
  resume: resume_30,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_30,
  name: 'Compliance Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_30,
  name: 'Quality Control',
  kind: :secondary
)

SkillItem.create(
  resume: resume_30,
  name: 'Risk Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_30,
  position: 'Senior Quality Assurance Manager',
  company: 'Shopify',
  location: 'Austin, TX',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led quality assurance operations for a manufacturing organization with 300+ employees, implementing quality improvement initiatives that reduced defect rates by 40% and improved customer satisfaction scores by 35%. Developed and maintained quality management systems that ensured compliance with industry standards and regulatory requirements. Managed quality control processes and implemented continuous improvement methodologies that enhanced operational efficiency and product quality.'
)

WorkExperienceItem.create(
  resume: resume_30,
  position: 'Quality Assurance Manager',
  company: 'Process Quality Solutions',
  location: 'Austin, TX',
  start_month: 11,
  start_year: 2020,
  end_month: 6,
  end_year: 2022,
  description: 'Managed quality assurance processes and ensured compliance with quality standards and regulatory requirements. Implemented quality control measures and conducted quality audits. Coordinated with production teams to address quality issues and implement corrective actions.'
)

ExternalLinkItem.create(
  resume: resume_30,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate30'
)

ReferenceItem.create(
  resume: resume_30,
  name: 'Carlos Rodriguez',
  position: 'Quality Director',
  company: 'Quality Excellence Corp',
  mobile: '+1 555 0030',
  kind: :job
)

ReferenceItem.create(
  resume: resume_30,
  name: 'Sarah Johnson',
  position: 'Process Manager',
  company: 'Process Quality Solutions',
  mobile: '+1 555 0030',
  kind: :personal
)

# Candidate 31
candidate_31 = Candidate.new(email: 'candidate_31@simplestresumes.com', password: password)
candidate_31.skip_confirmation!
candidate_31.save

resume_31 = Resume.create(
  candidate_id: candidate_31.id,
  name: 'Matthew Johnson',
  email: candidate_31.email,
  mobile: '+1 555 0031',
  location: 'Raleigh, NC',
  about_me: 'Innovative software architect with expertise in system design and technical leadership. I design scalable solutions that meet business needs and drive technological advancement.'
)

EducationItem.create(
  resume_id: resume_31.id,
  name: 'Computer Science',
  institute: 'North Carolina State University',
  start_year: 2016,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_31.id,
  name: 'AWS Solutions Architect',
  institute: 'Amazon Web Services',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_31,
  name: 'Software Architecture',
  kind: :primary
)

SkillItem.create(
  resume: resume_31,
  name: 'System Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_31,
  name: 'Technical Leadership',
  kind: :primary
)

SkillItem.create(
  resume: resume_31,
  name: 'Cloud Architecture',
  kind: :secondary
)

SkillItem.create(
  resume: resume_31,
  name: 'Microservices',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_31,
  position: 'Senior Software Architect',
  company: 'JP Morgan',
  location: 'Raleigh, NC',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led architectural design for enterprise software systems serving over 500,000 users, implementing scalable solutions that improved system performance by 60% and reduced infrastructure costs by 35%. Designed and implemented microservices architecture that enhanced system reliability and enabled rapid feature development. Provided technical leadership to development teams and established architectural standards that ensured code quality and system maintainability.'
)

WorkExperienceItem.create(
  resume: resume_31,
  position: 'Software Architect',
  company: 'JP Morgan',
  location: 'Raleigh, NC',
  start_month: 6,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Designed software architecture for various client projects and provided technical guidance to development teams. Collaborated with stakeholders to understand system requirements and develop architectural solutions. Established coding standards and best practices for development teams.'
)

ExternalLinkItem.create(
  resume: resume_31,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate31'
)

ExternalLinkItem.create(
  resume: resume_31,
  name: 'GitHub',
  url: 'https://github.com/candidate31'
)

ReferenceItem.create(
  resume: resume_31,
  name: 'Jennifer Lee',
  position: 'CTO',
  company: 'Tech Architecture Solutions',
  mobile: '+1 555 0031',
  kind: :job
)

ReferenceItem.create(
  resume: resume_31,
  name: 'David Chen',
  position: 'Technical Director',
  company: 'System Design Pro',
  mobile: '+1 555 0031',
  kind: :personal
)

# Candidate 32
candidate_32 = Candidate.new(email: 'candidate_32@simplestresumes.com', password: password)
candidate_32.skip_confirmation!
candidate_32.save

resume_32 = Resume.create(
  candidate_id: candidate_32.id,
  name: 'Elizabeth Wilson',
  email: candidate_32.email,
  mobile: '+1 555 0032',
  location: 'Salt Lake City, UT',
  about_me: 'Creative graphic designer with expertise in visual communication and brand identity. I create compelling visual designs that effectively communicate messages and enhance brand recognition.'
)

EducationItem.create(
  resume_id: resume_32.id,
  name: 'Graphic Design',
  institute: 'University of Utah',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_32.id,
  name: 'Adobe Creative Suite Certification',
  institute: 'Adobe',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_32,
  name: 'Graphic Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_32,
  name: 'Visual Communication',
  kind: :primary
)

SkillItem.create(
  resume: resume_32,
  name: 'Brand Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_32,
  name: 'Typography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_32,
  name: 'Layout Design',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_32,
  position: 'Senior Graphic Designer',
  company: 'JP Morgan',
  location: 'Salt Lake City, UT',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led creative design projects for major brands and organizations, developing visual identities and marketing materials that increased brand recognition by 45% and improved customer engagement. Managed design teams and creative processes, ensuring high-quality deliverables that met client objectives and brand guidelines. Collaborated with marketing teams to develop cohesive visual strategies that supported business goals and enhanced brand presence.'
)

WorkExperienceItem.create(
  resume: resume_32,
  position: 'Graphic Designer',
  company: 'JP Morgan',
  location: 'Salt Lake City, UT',
  start_month: 3,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Created graphic designs for various client projects including logos, marketing materials, and digital assets. Worked with creative teams to develop visual concepts and ensure brand consistency. Managed multiple design projects and met client deadlines.'
)

ExternalLinkItem.create(
  resume: resume_32,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate32'
)

ExternalLinkItem.create(
  resume: resume_32,
  name: 'Behance',
  url: 'https://behance.net/candidate32'
)

ReferenceItem.create(
  resume: resume_32,
  name: 'Michael Rodriguez',
  position: 'Creative Director',
  company: 'Creative Design Studio',
  mobile: '+1 555 0032',
  kind: :job
)

ReferenceItem.create(
  resume: resume_32,
  name: 'Sarah Kim',
  position: 'Design Manager',
  company: 'Visual Design Agency',
  mobile: '+1 555 0032',
  kind: :personal
)

# Candidate 33
candidate_33 = Candidate.new(email: 'candidate_33@simplestresumes.com', password: password)
candidate_33.skip_confirmation!
candidate_33.save

resume_33 = Resume.create(
  candidate_id: candidate_33.id,
  name: 'Andrew Davis',
  email: candidate_33.email,
  mobile: '+1 555 0033',
  location: 'Tampa, FL',
  about_me: 'Strategic human resources professional with expertise in talent acquisition and employee development. I build high-performing teams and create positive workplace cultures.'
)

EducationItem.create(
  resume_id: resume_33.id,
  name: 'Human Resources',
  institute: 'University of South Florida',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_33.id,
  name: 'SHRM-CP Certification',
  institute: 'SHRM',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_33,
  name: 'Talent Acquisition',
  kind: :primary
)

SkillItem.create(
  resume: resume_33,
  name: 'Employee Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_33,
  name: 'HR Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_33,
  name: 'Performance Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_33,
  name: 'Employee Relations',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_33,
  position: 'Senior HR Manager',
  company: 'JP Morgan',
  location: 'Tampa, FL',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led human resources operations for a growing organization with 300+ employees, implementing HR strategies that improved employee retention by 30% and enhanced workplace satisfaction scores. Managed talent acquisition processes and employee development programs that supported organizational growth and career advancement. Developed and maintained HR policies and procedures that ensured compliance with employment laws and created positive workplace environments.'
)

WorkExperienceItem.create(
  resume: resume_33,
  position: 'HR Manager',
  company: 'Talent Solutions Inc',
  location: 'Tampa, FL',
  start_month: 5,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Managed HR operations and supported employee recruitment and development initiatives. Implemented HR policies and procedures and ensured compliance with employment regulations. Coordinated with management teams to address employee relations and performance management needs.'
)

ExternalLinkItem.create(
  resume: resume_33,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate33'
)

ReferenceItem.create(
  resume: resume_33,
  name: 'Lisa Anderson',
  position: 'HR Director',
  company: 'HR Excellence Group',
  mobile: '+1 555 0033',
  kind: :job
)

ReferenceItem.create(
  resume: resume_33,
  name: 'Robert Wilson',
  position: 'HR Manager',
  company: 'Talent Solutions Inc',
  mobile: '+1 555 0033',
  kind: :personal
)

# Candidate 34
candidate_34 = Candidate.new(email: 'candidate_34@simplestresumes.com', password: password)
candidate_34.skip_confirmation!
candidate_34.save

resume_34 = Resume.create(
  candidate_id: candidate_34.id,
  name: 'Michelle Brown',
  email: candidate_34.email,
  mobile: '+1 555 0034',
  location: 'Cleveland, OH',
  about_me: 'Experienced event planner with expertise in corporate events and special occasions. I create memorable experiences that exceed expectations and achieve client objectives.'
)

EducationItem.create(
  resume_id: resume_34.id,
  name: 'Event Management',
  institute: 'Cleveland State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_34.id,
  name: 'CMP Certification',
  institute: 'Events Industry Council',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_34,
  name: 'Event Planning',
  kind: :primary
)

SkillItem.create(
  resume: resume_34,
  name: 'Corporate Events',
  kind: :primary
)

SkillItem.create(
  resume: resume_34,
  name: 'Vendor Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_34,
  name: 'Budget Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_34,
  name: 'Logistics Coordination',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_34,
  position: 'Senior Event Planner',
  company: 'Bank of America',
  location: 'Cleveland, OH',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led planning and execution of major corporate events and special occasions for high-profile clients, managing events with budgets exceeding $500K and ensuring exceptional guest experiences. Coordinated with vendors, venues, and client teams to deliver seamless events that met all objectives and exceeded expectations. Developed event strategies and managed logistics that ensured successful execution and positive client feedback.'
)

WorkExperienceItem.create(
  resume: resume_34,
  position: 'Event Planner',
  company: 'Bank of America',
  location: 'Cleveland, OH',
  start_month: 8,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Planned and coordinated various events including corporate functions, weddings, and special celebrations. Managed vendor relationships and coordinated logistics to ensure successful event execution. Worked with clients to understand event requirements and deliver memorable experiences.'
)

ExternalLinkItem.create(
  resume: resume_34,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate34'
)

ExternalLinkItem.create(
  resume: resume_34,
  name: 'Event Portfolio',
  url: 'https://candidate34-events.com'
)

ReferenceItem.create(
  resume: resume_34,
  name: 'Jennifer Smith',
  position: 'Event Director',
  company: 'Event Excellence Corp',
  mobile: '+1 555 0034',
  kind: :job
)

ReferenceItem.create(
  resume: resume_34,
  name: 'Mark Johnson',
  position: 'Event Manager',
  company: 'Creative Events Pro',
  mobile: '+1 555 0034',
  kind: :personal
)

# Candidate 35
candidate_35 = Candidate.new(email: 'candidate_35@simplestresumes.com', password: password)
candidate_35.skip_confirmation!
candidate_35.save

resume_35 = Resume.create(
  candidate_id: candidate_35.id,
  name: 'Thomas Wilson',
  email: candidate_35.email,
  mobile: '+1 555 0035',
  location: 'Pittsburgh, PA',
  about_me: 'Innovative business consultant with expertise in strategic planning and organizational development. I help organizations optimize performance and achieve sustainable growth.'
)

EducationItem.create(
  resume_id: resume_35.id,
  name: 'Business Administration',
  institute: 'University of Pittsburgh',
  start_year: 2016,
  end_year: 2020
)

EducationItem.create(
  resume_id: resume_35.id,
  name: 'Management Consulting Certification',
  institute: 'McKinsey',
  start_year: 2020,
  end_year: 2020
)

SkillItem.create(
  resume: resume_35,
  name: 'Strategic Planning',
  kind: :primary
)

SkillItem.create(
  resume: resume_35,
  name: 'Organizational Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_35,
  name: 'Business Consulting',
  kind: :primary
)

SkillItem.create(
  resume: resume_35,
  name: 'Change Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_35,
  name: 'Performance Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_35,
  position: 'Senior Business Consultant',
  company: 'Bank of America',
  location: 'Pittsburgh, PA',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led strategic consulting engagements for Fortune 500 companies, delivering solutions that improved operational efficiency by 40% and increased profitability by 25%. Developed comprehensive business strategies and organizational development plans that supported long-term growth objectives. Managed client relationships and project teams, ensuring successful delivery of consulting services and measurable business outcomes.'
)

WorkExperienceItem.create(
  resume: resume_35,
  position: 'Business Consultant',
  company: 'Bank of America',
  location: 'Pittsburgh, PA',
  start_month: 11,
  start_year: 2020,
  end_month: 6,
  end_year: 2022,
  description: 'Provided business consulting services to various client organizations, analyzing business processes and developing improvement recommendations. Conducted organizational assessments and supported strategic planning initiatives. Worked with client teams to implement recommended changes and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_35,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate35'
)

ReferenceItem.create(
  resume: resume_35,
  name: 'Sarah Davis',
  position: 'Consulting Director',
  company: 'Strategic Consulting Group',
  mobile: '+1 555 0035',
  kind: :job
)

ReferenceItem.create(
  resume: resume_35,
  name: 'David Brown',
  position: 'Senior Consultant',
  company: 'Management Solutions Pro',
  mobile: '+1 555 0035',
  kind: :personal
)

# Candidate 36
candidate_36 = Candidate.new(email: 'candidate_36@simplestresumes.com', password: password)
candidate_36.skip_confirmation!
candidate_36.save

resume_36 = Resume.create(
  candidate_id: candidate_36.id,
  name: 'Amanda Johnson',
  email: candidate_36.email,
  mobile: '+1 555 0036',
  location: 'Cincinnati, OH',
  about_me: 'Creative copywriter with expertise in persuasive writing and brand messaging. I craft compelling content that engages audiences and drives action through strategic storytelling.'
)

EducationItem.create(
  resume_id: resume_36.id,
  name: 'English Literature',
  institute: 'University of Cincinnati',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_36.id,
  name: 'Copywriting Certification',
  institute: 'Copyblogger',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_36,
  name: 'Copywriting',
  kind: :primary
)

SkillItem.create(
  resume: resume_36,
  name: 'Persuasive Writing',
  kind: :primary
)

SkillItem.create(
  resume: resume_36,
  name: 'Brand Messaging',
  kind: :primary
)

SkillItem.create(
  resume: resume_36,
  name: 'Content Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_36,
  name: 'SEO Writing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_36,
  position: 'Senior Copywriter',
  company: 'Bank of America',
  location: 'Cincinnati, OH',
  start_month: 2,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led copywriting initiatives for major brands and marketing campaigns, creating compelling content that increased conversion rates by 35% and improved brand engagement across multiple channels. Developed brand voice guidelines and messaging strategies that ensured consistent communication and enhanced brand recognition. Collaborated with creative teams to develop integrated marketing campaigns that effectively communicated brand messages and drove desired customer actions.'
)

WorkExperienceItem.create(
  resume: resume_36,
  position: 'Copywriter',
  company: 'Content Creation Pro',
  location: 'Cincinnati, OH',
  start_month: 9,
  start_year: 2020,
  end_month: 1,
  end_year: 2022,
  description: 'Created compelling copy for various marketing materials including websites, advertisements, and promotional content. Developed brand messaging and ensured consistency across all communication channels. Worked with creative teams to develop effective marketing campaigns.'
)

ExternalLinkItem.create(
  resume: resume_36,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate36'
)

ExternalLinkItem.create(
  resume: resume_36,
  name: 'Writing Portfolio',
  url: 'https://candidate36-writing-portfolio.com'
)

ReferenceItem.create(
  resume: resume_36,
  name: 'Michael Rodriguez',
  position: 'Creative Director',
  company: 'Creative Copy Solutions',
  mobile: '+1 555 0036',
  kind: :job
)

ReferenceItem.create(
  resume: resume_36,
  name: 'Lisa Chen',
  position: 'Content Manager',
  company: 'Content Creation Pro',
  mobile: '+1 555 0036',
  kind: :personal
)

# Candidate 37
candidate_37 = Candidate.new(email: 'candidate_37@simplestresumes.com', password: password)
candidate_37.skip_confirmation!
candidate_37.save

resume_37 = Resume.create(
  candidate_id: candidate_37.id,
  name: 'Kevin Davis',
  email: candidate_37.email,
  mobile: '+1 555 0037',
  location: 'Milwaukee, WI',
  about_me: 'Strategic sales manager with expertise in team leadership and revenue growth. I build high-performing sales teams that consistently exceed targets and drive business success.'
)

EducationItem.create(
  resume_id: resume_37.id,
  name: 'Sales Management',
  institute: 'University of Wisconsin',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_37.id,
  name: 'Sales Leadership Certification',
  institute: 'Sales Management Association',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_37,
  name: 'Sales Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_37,
  name: 'Team Leadership',
  kind: :primary
)

SkillItem.create(
  resume: resume_37,
  name: 'Revenue Growth',
  kind: :primary
)

SkillItem.create(
  resume: resume_37,
  name: 'Sales Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_37,
  name: 'Customer Relationship',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_37,
  position: 'Senior Sales Manager',
  company: 'Wells Fargo',
  location: 'Milwaukee, WI',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led sales operations for a regional territory with 25 sales representatives, achieving 45% revenue growth and exceeding annual targets by 20% for three consecutive years. Developed and implemented sales strategies that improved team performance and increased market share in competitive markets. Managed key account relationships and provided coaching and development opportunities that enhanced team capabilities and performance.'
)

WorkExperienceItem.create(
  resume: resume_37,
  position: 'Sales Manager',
  company: 'Wells Fargo',
  location: 'Milwaukee, WI',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Managed sales team performance and developed sales strategies to achieve revenue targets. Provided coaching and training to sales representatives and managed key customer relationships. Analyzed sales data and implemented improvement initiatives.'
)

ExternalLinkItem.create(
  resume: resume_37,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate37'
)

ReferenceItem.create(
  resume: resume_37,
  name: 'Jennifer Wilson',
  position: 'Sales Director',
  company: 'Sales Excellence Corp',
  mobile: '+1 555 0037',
  kind: :job
)

ReferenceItem.create(
  resume: resume_37,
  name: 'Robert Brown',
  position: 'Regional Manager',
  company: 'Revenue Solutions Inc',
  mobile: '+1 555 0037',
  kind: :personal
)

# Candidate 38
candidate_38 = Candidate.new(email: 'candidate_38@simplestresumes.com', password: password)
candidate_38.skip_confirmation!
candidate_38.save

resume_38 = Resume.create(
  candidate_id: candidate_38.id,
  name: 'Nicole Anderson',
  email: candidate_38.email,
  mobile: '+1 555 0038',
  location: 'Albuquerque, NM',
  about_me: 'Innovative product designer with expertise in user-centered design and creative problem-solving. I create products that delight users and solve real-world problems.'
)

EducationItem.create(
  resume_id: resume_38.id,
  name: 'Product Design',
  institute: 'University of New Mexico',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_38.id,
  name: 'Design Thinking Certification',
  institute: 'IDEO',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_38,
  name: 'Product Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_38,
  name: 'User-Centered Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_38,
  name: 'Creative Problem Solving',
  kind: :primary
)

SkillItem.create(
  resume: resume_38,
  name: 'Prototyping',
  kind: :secondary
)

SkillItem.create(
  resume: resume_38,
  name: 'Design Research',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_38,
  position: 'Senior Product Designer',
  company: 'Wells Fargo',
  location: 'Albuquerque, NM',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product design initiatives for consumer and enterprise products, creating innovative solutions that increased user satisfaction by 50% and improved product usability scores. Conducted user research and design thinking workshops that informed product development and ensured user needs were met. Collaborated with engineering and product teams to develop design solutions that balanced user experience with technical feasibility.'
)

WorkExperienceItem.create(
  resume: resume_38,
  position: 'Product Designer',
  company: 'Wells Fargo',
  location: 'Albuquerque, NM',
  start_month: 12,
  start_year: 2020,
  end_month: 7,
  end_year: 2022,
  description: 'Designed user interfaces and product experiences for various client projects. Conducted user research and developed design concepts that addressed user needs and business objectives. Created prototypes and worked with development teams to implement design solutions.'
)

ExternalLinkItem.create(
  resume: resume_38,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate38'
)

ExternalLinkItem.create(
  resume: resume_38,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate38'
)

ReferenceItem.create(
  resume: resume_38,
  name: 'David Kim',
  position: 'Design Director',
  company: 'Design Innovation Studio',
  mobile: '+1 555 0038',
  kind: :job
)

ReferenceItem.create(
  resume: resume_38,
  name: 'Sarah Rodriguez',
  position: 'Creative Manager',
  company: 'Creative Design Lab',
  mobile: '+1 555 0038',
  kind: :personal
)

# Candidate 39
candidate_39 = Candidate.new(email: 'candidate_39@simplestresumes.com', password: password)
candidate_39.skip_confirmation!
candidate_39.save

resume_39 = Resume.create(
  candidate_id: candidate_39.id,
  name: 'James Wilson',
  email: candidate_39.email,
  mobile: '+1 555 0039',
  location: 'Tucson, AZ',
  about_me: 'Strategic financial planner with expertise in investment management and retirement planning. I help individuals and families achieve their financial goals through comprehensive planning.'
)

EducationItem.create(
  resume_id: resume_39.id,
  name: 'Finance',
  institute: 'University of Arizona',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_39.id,
  name: 'CFP Certification',
  institute: 'CFP Board',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_39,
  name: 'Financial Planning',
  kind: :primary
)

SkillItem.create(
  resume: resume_39,
  name: 'Investment Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_39,
  name: 'Retirement Planning',
  kind: :primary
)

SkillItem.create(
  resume: resume_39,
  name: 'Risk Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_39,
  name: 'Tax Planning',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_39,
  position: 'Senior Financial Planner',
  company: 'Wells Fargo',
  location: 'Tucson, AZ',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive financial planning services for high-net-worth clients, managing investment portfolios exceeding $50M and developing strategies that achieved 12% average annual returns. Created personalized financial plans that addressed retirement, education, and estate planning needs while optimizing tax efficiency. Built long-term client relationships and provided ongoing financial guidance that supported clients in achieving their financial objectives.'
)

WorkExperienceItem.create(
  resume: resume_39,
  position: 'Financial Planner',
  company: 'Wealth Management Pro',
  location: 'Tucson, AZ',
  start_month: 7,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Provided financial planning services to individual and family clients, developing comprehensive financial strategies and investment recommendations. Conducted financial assessments and created personalized planning solutions. Maintained client relationships and provided ongoing financial guidance.'
)

ExternalLinkItem.create(
  resume: resume_39,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate39'
)

ReferenceItem.create(
  resume: resume_39,
  name: 'Maria Gonzalez',
  position: 'Financial Planning Director',
  company: 'Financial Planning Group',
  mobile: '+1 555 0039',
  kind: :job
)

ReferenceItem.create(
  resume: resume_39,
  name: 'John Anderson',
  position: 'Senior Planner',
  company: 'Wealth Management Pro',
  mobile: '+1 555 0039',
  kind: :personal
)

# Candidate 40
candidate_40 = Candidate.new(email: 'candidate_40@simplestresumes.com', password: password)
candidate_40.skip_confirmation!
candidate_40.save

resume_40 = Resume.create(
  candidate_id: candidate_40.id,
  name: 'Stephanie Johnson',
  email: candidate_40.email,
  mobile: '+1 555 0040',
  location: 'Fresno, CA',
  about_me: 'Creative social media manager with expertise in digital marketing and community engagement. I build engaged online communities that drive brand awareness and customer loyalty.'
)

EducationItem.create(
  resume_id: resume_40.id,
  name: 'Digital Marketing',
  institute: 'California State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_40.id,
  name: 'Social Media Marketing Certification',
  institute: 'Hootsuite',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_40,
  name: 'Social Media Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_40,
  name: 'Digital Marketing',
  kind: :primary
)

SkillItem.create(
  resume: resume_40,
  name: 'Community Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_40,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_40,
  name: 'Analytics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_40,
  position: 'Senior Social Media Manager',
  company: 'Walmart',
  location: 'Fresno, CA',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led social media strategies for major brands across multiple platforms, increasing follower engagement by 65% and improving brand awareness by 40% through strategic content and community management. Developed comprehensive social media campaigns that aligned with marketing objectives and drove measurable business results. Managed online communities and fostered meaningful interactions that enhanced brand loyalty and customer relationships.'
)

WorkExperienceItem.create(
  resume: resume_40,
  position: 'Social Media Manager',
  company: 'Walmart',
  location: 'Fresno, CA',
  start_month: 10,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Managed social media presence for various client accounts and developed content strategies that increased engagement and brand visibility. Created engaging content and managed online communities. Analyzed social media performance and implemented optimization strategies.'
)

ExternalLinkItem.create(
  resume: resume_40,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate40'
)

ExternalLinkItem.create(
  resume: resume_40,
  name: 'Twitter',
  url: 'https://twitter.com/candidate40'
)

ReferenceItem.create(
  resume: resume_40,
  name: 'Christopher Lee',
  position: 'Digital Marketing Director',
  company: 'Social Media Pro',
  mobile: '+1 555 0040',
  kind: :job
)

ReferenceItem.create(
  resume: resume_40,
  name: 'Lisa Chen',
  position: 'Marketing Manager',
  company: 'Digital Marketing Solutions',
  mobile: '+1 555 0040',
  kind: :personal
)

# Candidate 41
candidate_41 = Candidate.new(email: 'candidate_41@simplestresumes.com', password: password)
candidate_41.skip_confirmation!
candidate_41.save

resume_41 = Resume.create(
  candidate_id: candidate_41.id,
  name: 'Robert Davis',
  email: candidate_41.email,
  mobile: '+1 555 0041',
  location: 'Sacramento, CA',
  about_me: 'Strategic business analyst with expertise in process optimization and data-driven decision making. I help organizations improve efficiency and achieve operational excellence.'
)

EducationItem.create(
  resume_id: resume_41.id,
  name: 'Business Analysis',
  institute: 'California State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_41.id,
  name: 'Six Sigma Green Belt',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_41,
  name: 'Business Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_41,
  name: 'Process Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_41,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_41,
  name: 'Requirements Gathering',
  kind: :secondary
)

SkillItem.create(
  resume: resume_41,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_41,
  position: 'Senior Business Analyst',
  company: 'Walmart',
  location: 'Sacramento, CA',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business analysis initiatives that identified and implemented process improvements resulting in 35% reduction in operational costs and 45% improvement in process efficiency. Conducted comprehensive business process analysis and developed recommendations for optimization that supported organizational goals and improved customer experience. Managed stakeholder relationships and facilitated workshops to gather requirements and ensure alignment on business objectives.'
)

WorkExperienceItem.create(
  resume: resume_41,
  position: 'Business Analyst',
  company: 'Walmart',
  location: 'Sacramento, CA',
  start_month: 1,
  start_year: 2021,
  end_month: 7,
  end_year: 2022,
  description: 'Analyzed business processes and gathered requirements for system improvements and process optimization projects. Created business process documentation and worked with stakeholders to ensure accurate requirement definition. Supported project teams in implementing process improvements and system enhancements.'
)

ExternalLinkItem.create(
  resume: resume_41,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate41'
)

ReferenceItem.create(
  resume: resume_41,
  name: 'Amanda Rodriguez',
  position: 'Business Analysis Director',
  company: 'Business Optimization Group',
  mobile: '+1 555 0041',
  kind: :job
)

ReferenceItem.create(
  resume: resume_41,
  name: 'Carlos Mendez',
  position: 'Process Manager',
  company: 'Process Solutions Inc',
  mobile: '+1 555 0041',
  kind: :personal
)

# Candidate 42
candidate_42 = Candidate.new(email: 'candidate_42@simplestresumes.com', password: password)
candidate_42.skip_confirmation!
candidate_42.save

resume_42 = Resume.create(
  candidate_id: candidate_42.id,
  name: 'Jennifer Wilson',
  email: candidate_42.email,
  mobile: '+1 555 0042',
  location: 'Long Beach, CA',
  about_me: 'Creative marketing coordinator with expertise in campaign execution and brand management. I coordinate marketing efforts that drive results and enhance brand presence.'
)

EducationItem.create(
  resume_id: resume_42.id,
  name: 'Marketing',
  institute: 'California State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_42.id,
  name: 'Digital Marketing Certification',
  institute: 'Google Digital Garage',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_42,
  name: 'Campaign Execution',
  kind: :primary
)

SkillItem.create(
  resume: resume_42,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_42,
  name: 'Marketing Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_42,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_42,
  name: 'Social Media',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_42,
  position: 'Senior Marketing Coordinator',
  company: 'Walmart',
  location: 'Long Beach, CA',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated comprehensive marketing campaigns for major brands, managing multiple channels and ensuring consistent messaging that increased brand awareness by 40% and improved customer engagement. Developed and executed marketing strategies that aligned with business objectives and target audience preferences. Coordinated with creative teams, media partners, and stakeholders to ensure successful campaign delivery and measurable results.'
)

WorkExperienceItem.create(
  resume: resume_42,
  position: 'Marketing Coordinator',
  company: 'Creative Marketing Solutions',
  location: 'Long Beach, CA',
  start_month: 9,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Coordinated marketing campaigns and supported brand management initiatives for various client accounts. Assisted with content creation and social media management. Coordinated with creative teams and ensured campaign deliverables met quality standards.'
)

ExternalLinkItem.create(
  resume: resume_42,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate42'
)

ExternalLinkItem.create(
  resume: resume_42,
  name: 'Marketing Portfolio',
  url: 'https://candidate42-marketing-portfolio.com'
)

ReferenceItem.create(
  resume: resume_42,
  name: 'Michael Chen',
  position: 'Marketing Director',
  company: 'Marketing Excellence Corp',
  mobile: '+1 555 0042',
  kind: :job
)

ReferenceItem.create(
  resume: resume_42,
  name: 'Lisa Rodriguez',
  position: 'Brand Manager',
  company: 'Creative Marketing Solutions',
  mobile: '+1 555 0042',
  kind: :personal
)

# Candidate 43
candidate_43 = Candidate.new(email: 'candidate_43@simplestresumes.com', password: password)
candidate_43.skip_confirmation!
candidate_43.save

resume_43 = Resume.create(
  candidate_id: candidate_43.id,
  name: 'David Brown',
  email: candidate_43.email,
  mobile: '+1 555 0043',
  location: 'Kansas City, MO',
  about_me: 'Experienced project coordinator with expertise in team coordination and project delivery. I ensure projects are completed on time and within budget through effective coordination.'
)

EducationItem.create(
  resume_id: resume_43.id,
  name: 'Project Management',
  institute: 'University of Missouri',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_43.id,
  name: 'Agile Certification',
  institute: 'Scrum Alliance',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_43,
  name: 'Project Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_43,
  name: 'Team Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_43,
  name: 'Project Delivery',
  kind: :primary
)

SkillItem.create(
  resume: resume_43,
  name: 'Schedule Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_43,
  name: 'Resource Allocation',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_43,
  position: 'Senior Project Coordinator',
  company: 'ExxonMobil',
  location: 'Kansas City, MO',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated complex projects with budgets exceeding $1M, ensuring successful delivery within scope, budget, and timeline constraints while maintaining high quality standards. Managed cross-functional project teams and coordinated resources to ensure project milestones were met and objectives achieved. Developed and maintained project schedules, coordinated stakeholder communications, and managed project risks to ensure successful outcomes.'
)

WorkExperienceItem.create(
  resume: resume_43,
  position: 'Project Coordinator',
  company: 'ExxonMobil',
  location: 'Kansas City, MO',
  start_month: 6,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Coordinated project activities and supported project managers in delivering successful project outcomes. Managed project schedules and coordinated team resources. Assisted with stakeholder communications and project documentation.'
)

ExternalLinkItem.create(
  resume: resume_43,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate43'
)

ReferenceItem.create(
  resume: resume_43,
  name: 'Sarah Johnson',
  position: 'Project Director',
  company: 'Project Excellence Group',
  mobile: '+1 555 0043',
  kind: :job
)

ReferenceItem.create(
  resume: resume_43,
  name: 'Robert Wilson',
  position: 'Senior PM',
  company: 'Project Solutions Pro',
  mobile: '+1 555 0043',
  kind: :personal
)

# Candidate 44
candidate_44 = Candidate.new(email: 'candidate_44@simplestresumes.com', password: password)
candidate_44.skip_confirmation!
candidate_44.save

resume_44 = Resume.create(
  candidate_id: candidate_44.id,
  name: 'Lisa Anderson',
  email: candidate_44.email,
  mobile: '+1 555 0044',
  location: 'Mesa, AZ',
  about_me: 'Innovative web developer with expertise in front-end development and user experience. I create responsive websites that provide excellent user experiences and drive engagement.'
)

EducationItem.create(
  resume_id: resume_44.id,
  name: 'Web Development',
  institute: 'Arizona State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_44.id,
  name: 'React Certification',
  institute: 'Meta',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_44,
  name: 'Front-end Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_44,
  name: 'Web Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_44,
  name: 'User Experience',
  kind: :primary
)

SkillItem.create(
  resume: resume_44,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_44,
  name: 'CSS',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_44,
  position: 'Senior Web Developer',
  company: 'ExxonMobil',
  location: 'Mesa, AZ',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led web development projects for major clients, creating responsive websites and web applications that improved user engagement by 50% and enhanced online presence. Developed front-end solutions using modern technologies and best practices that ensured optimal performance and user experience. Collaborated with design and back-end teams to deliver cohesive web solutions that met client requirements and exceeded expectations.'
)

WorkExperienceItem.create(
  resume: resume_44,
  position: 'Web Developer',
  company: 'ExxonMobil',
  location: 'Mesa, AZ',
  start_month: 7,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Developed websites and web applications for various client projects. Created responsive designs and ensured cross-browser compatibility. Worked with design teams to implement visual designs and maintain code quality.'
)

ExternalLinkItem.create(
  resume: resume_44,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate44'
)

ExternalLinkItem.create(
  resume: resume_44,
  name: 'GitHub',
  url: 'https://github.com/candidate44'
)

ReferenceItem.create(
  resume: resume_44,
  name: 'Christopher Lee',
  position: 'Development Director',
  company: 'Web Development Studio',
  mobile: '+1 555 0044',
  kind: :job
)

ReferenceItem.create(
  resume: resume_44,
  name: 'David Kim',
  position: 'Senior Developer',
  company: 'Digital Web Solutions',
  mobile: '+1 555 0044',
  kind: :personal
)

# Candidate 45
candidate_45 = Candidate.new(email: 'candidate_45@simplestresumes.com', password: password)
candidate_45.skip_confirmation!
candidate_45.save

resume_45 = Resume.create(
  candidate_id: candidate_45.id,
  name: 'Michael Rodriguez',
  email: candidate_45.email,
  mobile: '+1 555 0045',
  location: 'Virginia Beach, VA',
  about_me: 'Strategic operations analyst with expertise in performance optimization and process improvement. I analyze operations to identify opportunities for enhancement and efficiency gains.'
)

EducationItem.create(
  resume_id: resume_45.id,
  name: 'Operations Management',
  institute: 'Old Dominion University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_45.id,
  name: 'Lean Six Sigma Certification',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_45,
  name: 'Operations Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_45,
  name: 'Performance Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_45,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_45,
  name: 'Data Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_45,
  name: 'Performance Metrics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_45,
  position: 'Senior Operations Analyst',
  company: 'ExxonMobil',
  location: 'Virginia Beach, VA',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led operations analysis initiatives that identified and implemented performance improvements resulting in 30% increase in operational efficiency and 25% reduction in costs while maintaining quality standards. Conducted comprehensive performance analysis and developed optimization strategies that supported organizational goals and improved customer satisfaction. Managed performance metrics and reporting systems that provided insights for continuous improvement and strategic decision-making.'
)

WorkExperienceItem.create(
  resume: resume_45,
  position: 'Operations Analyst',
  company: 'Performance Solutions Inc',
  location: 'Virginia Beach, VA',
  start_month: 2,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Analyzed operational performance and identified opportunities for improvement and optimization. Developed performance metrics and reporting systems to support operational decision-making. Supported process improvement initiatives and performance optimization projects.'
)

ExternalLinkItem.create(
  resume: resume_45,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate45'
)

ReferenceItem.create(
  resume: resume_45,
  name: 'Jennifer Wilson',
  position: 'Operations Director',
  company: 'Operations Excellence Corp',
  mobile: '+1 555 0045',
  kind: :job
)

ReferenceItem.create(
  resume: resume_45,
  name: 'Robert Brown',
  position: 'Performance Manager',
  company: 'Performance Solutions Inc',
  mobile: '+1 555 0045',
  kind: :personal
)

# Candidate 46
candidate_46 = Candidate.new(email: 'candidate_46@simplestresumes.com', password: password)
candidate_46.skip_confirmation!
candidate_46.save

resume_46 = Resume.create(
  candidate_id: candidate_46.id,
  name: 'Sarah Johnson',
  email: candidate_46.email,
  mobile: '+1 555 0046',
  location: 'Atlanta, GA',
  about_me: 'Creative content creator with expertise in storytelling and audience engagement. I develop compelling content that connects with audiences and drives meaningful engagement.'
)

EducationItem.create(
  resume_id: resume_46.id,
  name: 'Communications',
  institute: 'Georgia State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_46.id,
  name: 'Content Creation Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_46,
  name: 'Content Creation',
  kind: :primary
)

SkillItem.create(
  resume: resume_46,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_46,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_46,
  name: 'Content Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_46,
  name: 'Creative Writing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_46,
  position: 'Senior Content Creator',
  company: 'PepsiCo',
  location: 'Atlanta, GA',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content creation initiatives for major brands and organizations, developing compelling content that increased audience engagement by 55% and improved brand recognition across multiple platforms. Created diverse content types including articles, videos, and social media posts that effectively communicated brand messages and engaged target audiences. Collaborated with marketing teams to develop content strategies that aligned with business objectives and audience preferences.'
)

WorkExperienceItem.create(
  resume: resume_46,
  position: 'Content Creator',
  company: 'PepsiCo',
  location: 'Atlanta, GA',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Created engaging content for various client campaigns and platforms. Developed content strategies and created diverse content types to support marketing objectives. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_46,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate46'
)

ExternalLinkItem.create(
  resume: resume_46,
  name: 'Content Portfolio',
  url: 'https://candidate46-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_46,
  name: 'David Chen',
  position: 'Content Director',
  company: 'Content Creation Studio',
  mobile: '+1 555 0046',
  kind: :job
)

ReferenceItem.create(
  resume: resume_46,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0046',
  kind: :personal
)

# Candidate 47
candidate_47 = Candidate.new(email: 'candidate_47@simplestresumes.com', password: password)
candidate_47.skip_confirmation!
candidate_47.save

resume_47 = Resume.create(
  candidate_id: candidate_47.id,
  name: 'Christopher Lee',
  email: candidate_47.email,
  mobile: '+1 555 0047',
  location: 'Colorado Springs, CO',
  about_me: 'Experienced data analyst with expertise in statistical analysis and business intelligence. I transform data into actionable insights that support strategic decision-making.'
)

EducationItem.create(
  resume_id: resume_47.id,
  name: 'Data Science',
  institute: 'University of Colorado',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_47.id,
  name: 'Statistical Analysis Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_47,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_47,
  name: 'Statistical Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_47,
  name: 'Business Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_47,
  name: 'Data Visualization',
  kind: :secondary
)

SkillItem.create(
  resume: resume_47,
  name: 'SQL',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_47,
  position: 'Senior Data Analyst',
  company: 'PepsiCo',
  location: 'Colorado Springs, CO',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data analysis initiatives that provided critical insights for strategic decision-making, supporting business growth initiatives that increased revenue by 30% and improved operational efficiency by 25%. Conducted comprehensive statistical analysis and developed predictive models that identified trends and opportunities for business optimization. Created data visualizations and reports that effectively communicated complex analytical findings to stakeholders and supported data-driven decision-making.'
)

WorkExperienceItem.create(
  resume: resume_47,
  position: 'Data Analyst',
  company: 'PepsiCo',
  location: 'Colorado Springs, CO',
  start_month: 8,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Analyzed business data and conducted statistical analysis to support decision-making processes. Created data visualizations and reports that communicated insights to stakeholders. Supported business intelligence initiatives and data-driven decision-making.'
)

ExternalLinkItem.create(
  resume: resume_47,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate47'
)

ExternalLinkItem.create(
  resume: resume_47,
  name: 'GitHub',
  url: 'https://github.com/candidate47'
)

ReferenceItem.create(
  resume: resume_47,
  name: 'Amanda Rodriguez',
  position: 'Analytics Director',
  company: 'Data Analytics Group',
  mobile: '+1 555 0047',
  kind: :job
)

ReferenceItem.create(
  resume: resume_47,
  name: 'Michael Chen',
  position: 'Senior Analyst',
  company: 'Analytics Solutions Pro',
  mobile: '+1 555 0047',
  kind: :personal
)

# Candidate 48
candidate_48 = Candidate.new(email: 'candidate_48@simplestresumes.com', password: password)
candidate_48.skip_confirmation!
candidate_48.save

resume_48 = Resume.create(
  candidate_id: candidate_48.id,
  name: 'Nicole Wilson',
  email: candidate_48.email,
  mobile: '+1 555 0048',
  location: 'Raleigh, NC',
  about_me: 'Innovative product manager with expertise in agile methodologies and user-centered design. I deliver products that solve real problems and create meaningful user experiences.'
)

EducationItem.create(
  resume_id: resume_48.id,
  name: 'Product Management',
  institute: 'North Carolina State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_48.id,
  name: 'Agile Scrum Master',
  institute: 'Scrum Alliance',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_48,
  name: 'Product Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_48,
  name: 'Agile Methodologies',
  kind: :primary
)

SkillItem.create(
  resume: resume_48,
  name: 'User-Centered Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_48,
  name: 'Product Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_48,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_48,
  position: 'Senior Product Manager',
  company: 'PepsiCo',
  location: 'Raleigh, NC',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy and development for a portfolio of digital products serving over 150,000 users, resulting in 40% increase in user engagement and 30% improvement in customer satisfaction scores. Managed cross-functional product teams using agile methodologies, ensuring timely delivery of high-quality products that met user needs and business objectives. Conducted user research and market analysis to inform product decisions and prioritize feature development.'
)

WorkExperienceItem.create(
  resume: resume_48,
  position: 'Product Manager',
  company: 'Digital Products Solutions',
  location: 'Raleigh, NC',
  start_month: 7,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Managed product development lifecycle for multiple digital products, working with development teams to deliver features and improvements. Conducted user research and gathered feedback to inform product decisions and prioritize development efforts. Collaborated with stakeholders to define product requirements and ensure successful product launches.'
)

ExternalLinkItem.create(
  resume: resume_48,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate48'
)

ExternalLinkItem.create(
  resume: resume_48,
  name: 'Product Blog',
  url: 'https://candidate48-product-blog.com'
)

ReferenceItem.create(
  resume: resume_48,
  name: 'Jessica Taylor',
  position: 'VP of Product',
  company: 'Product Innovation Corp',
  mobile: '+1 555 0048',
  kind: :job
)

ReferenceItem.create(
  resume: resume_48,
  name: 'Mark Johnson',
  position: 'Product Director',
  company: 'Digital Products Solutions',
  mobile: '+1 555 0048',
  kind: :personal
)

# Candidate 49
candidate_49 = Candidate.new(email: 'candidate_49@simplestresumes.com', password: password)
candidate_49.skip_confirmation!
candidate_49.save

resume_49 = Resume.create(
  candidate_id: candidate_49.id,
  name: 'Andrew Davis',
  email: candidate_49.email,
  mobile: '+1 555 0049',
  location: 'Miami, FL',
  about_me: 'Strategic business development professional with expertise in market expansion and partnership development. I identify opportunities and build strategic relationships.'
)

EducationItem.create(
  resume_id: resume_49.id,
  name: 'Business Development',
  institute: 'University of Miami',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_49.id,
  name: 'Strategic Partnerships Certification',
  institute: 'Business Development Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_49,
  name: 'Business Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_49,
  name: 'Market Expansion',
  kind: :primary
)

SkillItem.create(
  resume: resume_49,
  name: 'Partnership Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_49,
  name: 'Strategic Planning',
  kind: :secondary
)

SkillItem.create(
  resume: resume_49,
  name: 'Relationship Building',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_49,
  position: 'Senior Business Development Manager',
  company: 'Nike',
  location: 'Miami, FL',
  start_month: 11,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business development initiatives that expanded market presence into 6 new territories and established strategic partnerships that generated $15M in additional revenue. Developed and executed market expansion strategies that identified new opportunities and positioned the company for sustainable growth in emerging markets. Built and maintained relationships with key partners, clients, and stakeholders that supported business objectives and created new revenue streams.'
)

WorkExperienceItem.create(
  resume: resume_49,
  position: 'Business Development Manager',
  company: 'Nike',
  location: 'Miami, FL',
  start_month: 5,
  start_year: 2021,
  end_month: 10,
  end_year: 2022,
  description: 'Identified new business opportunities and developed strategies for market expansion and growth. Built relationships with potential partners and clients to support business development objectives. Conducted market research and analysis to inform business development strategies.'
)

ExternalLinkItem.create(
  resume: resume_49,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate49'
)

ReferenceItem.create(
  resume: resume_49,
  name: 'David Thompson',
  position: 'Business Development Director',
  company: 'Business Growth Partners',
  mobile: '+1 555 0049',
  kind: :job
)

ReferenceItem.create(
  resume: resume_49,
  name: 'Lisa Anderson',
  position: 'Partnership Manager',
  company: 'Strategic Partnerships Inc',
  mobile: '+1 555 0049',
  kind: :personal
)

# Candidate 50
candidate_50 = Candidate.new(email: 'candidate_50@simplestresumes.com', password: password)
candidate_50.skip_confirmation!
candidate_50.save

resume_50 = Resume.create(
  candidate_id: candidate_50.id,
  name: 'Michelle Johnson',
  email: candidate_50.email,
  mobile: '+1 555 0050',
  location: 'Oakland, CA',
  about_me: 'Creative UX researcher with expertise in user behavior analysis and usability testing. I uncover insights that inform design decisions and improve user experiences.'
)

EducationItem.create(
  resume_id: resume_50.id,
  name: 'User Experience Research',
  institute: 'University of California',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_50.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_50,
  name: 'UX Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_50,
  name: 'User Behavior Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_50,
  name: 'Usability Testing',
  kind: :primary
)

SkillItem.create(
  resume: resume_50,
  name: 'Data Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_50,
  name: 'Research Methods',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_50,
  position: 'Senior UX Researcher',
  company: 'Nike',
  location: 'Oakland, CA',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive UX research initiatives for digital products serving millions of users, conducting studies that provided critical insights for design decisions and improved user satisfaction scores by 45%. Designed and executed research studies including user interviews, surveys, and usability testing that identified user needs and pain points. Collaborated with design and product teams to translate research findings into actionable design recommendations and product improvements.'
)

WorkExperienceItem.create(
  resume: resume_50,
  position: 'UX Researcher',
  company: 'Nike',
  location: 'Oakland, CA',
  start_month: 12,
  start_year: 2020,
  end_month: 6,
  end_year: 2022,
  description: 'Conducted UX research studies and usability testing for various digital products and applications. Analyzed user behavior and provided insights to inform design decisions. Worked with design teams to ensure user needs were addressed in product development.'
)

ExternalLinkItem.create(
  resume: resume_50,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate50'
)

ExternalLinkItem.create(
  resume: resume_50,
  name: 'Research Portfolio',
  url: 'https://candidate50-research-portfolio.com'
)

ReferenceItem.create(
  resume: resume_50,
  name: 'Emily Garcia',
  position: 'UX Research Director',
  company: 'UX Research Studio',
  mobile: '+1 555 0050',
  kind: :job
)

ReferenceItem.create(
  resume: resume_50,
  name: 'David Kim',
  position: 'Design Manager',
  company: 'User Experience Lab',
  mobile: '+1 555 0050',
  kind: :personal
)

# Candidate 51
candidate_51 = Candidate.new(email: 'candidate_51@simplestresumes.com', password: password)
candidate_51.skip_confirmation!
candidate_51.save

resume_51 = Resume.create(
  candidate_id: candidate_51.id,
  name: 'Jessica Brown',
  email: candidate_51.email,
  mobile: '+1 555 0051',
  location: 'Minneapolis, MN',
  about_me: 'Strategic marketing analyst with expertise in campaign performance and data-driven insights. I analyze marketing data to optimize campaigns and improve ROI.'
)

EducationItem.create(
  resume_id: resume_51.id,
  name: 'Marketing Analytics',
  institute: 'University of Minnesota',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_51.id,
  name: 'Google Analytics Certification',
  institute: 'Google',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_51,
  name: 'Marketing Analytics',
  kind: :primary
)

SkillItem.create(
  resume: resume_51,
  name: 'Campaign Performance',
  kind: :primary
)

SkillItem.create(
  resume: resume_51,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_51,
  name: 'ROI Optimization',
  kind: :secondary
)

SkillItem.create(
  resume: resume_51,
  name: 'Performance Metrics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_51,
  position: 'Senior Marketing Analyst',
  company: 'Nike',
  location: 'Minneapolis, MN',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led marketing analytics initiatives that provided critical insights for campaign optimization, resulting in 40% improvement in ROI and 35% increase in campaign performance across multiple channels. Analyzed campaign data and performance metrics to identify optimization opportunities and develop data-driven recommendations. Created comprehensive reports and dashboards that provided actionable insights for marketing teams and supported strategic decision-making.'
)

WorkExperienceItem.create(
  resume: resume_51,
  position: 'Marketing Analyst',
  company: 'Campaign Analytics Pro',
  location: 'Minneapolis, MN',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Analyzed marketing campaign performance and provided insights to optimize marketing strategies. Created performance reports and dashboards for various marketing channels. Supported marketing teams with data analysis and performance optimization recommendations.'
)

ExternalLinkItem.create(
  resume: resume_51,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate51'
)

ExternalLinkItem.create(
  resume: resume_51,
  name: 'Analytics Portfolio',
  url: 'https://candidate51-analytics-portfolio.com'
)

ReferenceItem.create(
  resume: resume_51,
  name: 'David Wilson',
  position: 'Marketing Analytics Director',
  company: 'Marketing Analytics Group',
  mobile: '+1 555 0051',
  kind: :job
)

ReferenceItem.create(
  resume: resume_51,
  name: 'Sarah Johnson',
  position: 'Senior Analyst',
  company: 'Campaign Analytics Pro',
  mobile: '+1 555 0051',
  kind: :personal
)

# Candidate 52
candidate_52 = Candidate.new(email: 'candidate_52@simplestresumes.com', password: password)
candidate_52.skip_confirmation!
candidate_52.save

resume_52 = Resume.create(
  candidate_id: candidate_52.id,
  name: 'Ryan Johnson',
  email: candidate_52.email,
  mobile: '+1 555 0052',
  location: 'Tulsa, OK',
  about_me: 'Innovative software engineer with expertise in full-stack development and system architecture. I build robust applications that solve complex problems efficiently.'
)

EducationItem.create(
  resume_id: resume_52.id,
  name: 'Computer Science',
  institute: 'University of Oklahoma',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_52.id,
  name: 'Full-Stack Development Certification',
  institute: 'Udemy',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_52,
  name: 'Full-Stack Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_52,
  name: 'Software Engineering',
  kind: :primary
)

SkillItem.create(
  resume: resume_52,
  name: 'System Architecture',
  kind: :primary
)

SkillItem.create(
  resume: resume_52,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_52,
  name: 'Python',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_52,
  position: 'Senior Software Engineer',
  company: 'General Motors',
  location: 'Tulsa, OK',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led full-stack development initiatives for enterprise applications serving over 200,000 users, implementing scalable solutions that improved system performance by 50% and reduced development time by 30%. Designed and developed system architectures that enhanced application reliability and enabled rapid feature development. Collaborated with cross-functional teams to deliver high-quality software solutions that met business requirements and exceeded user expectations.'
)

WorkExperienceItem.create(
  resume: resume_52,
  position: 'Software Engineer',
  company: 'General Motors',
  location: 'Tulsa, OK',
  start_month: 12,
  start_year: 2020,
  end_month: 7,
  end_year: 2022,
  description: 'Developed full-stack applications and software solutions for various client projects. Implemented system architectures and ensured code quality and performance. Worked with development teams to deliver software solutions that met client requirements.'
)

ExternalLinkItem.create(
  resume: resume_52,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate52'
)

ExternalLinkItem.create(
  resume: resume_52,
  name: 'GitHub',
  url: 'https://github.com/candidate52'
)

ReferenceItem.create(
  resume: resume_52,
  name: 'Jennifer Lee',
  position: 'Engineering Director',
  company: 'Tech Solutions Corp',
  mobile: '+1 555 0052',
  kind: :job
)

ReferenceItem.create(
  resume: resume_52,
  name: 'Michael Chen',
  position: 'Senior Engineer',
  company: 'Digital Development Lab',
  mobile: '+1 555 0052',
  kind: :personal
)

# Candidate 53
candidate_53 = Candidate.new(email: 'candidate_53@simplestresumes.com', password: password)
candidate_53.skip_confirmation!
candidate_53.save

resume_53 = Resume.create(
  candidate_id: candidate_53.id,
  name: 'Amanda Wilson',
  email: candidate_53.email,
  mobile: '+1 555 0053',
  location: 'Arlington, TX',
  about_me: 'Creative brand manager with expertise in brand strategy and visual identity. I develop comprehensive brand systems that strengthen market presence and customer loyalty.'
)

EducationItem.create(
  resume_id: resume_53.id,
  name: 'Brand Management',
  institute: 'University of Texas at Arlington',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_53.id,
  name: 'Brand Strategy Certification',
  institute: 'AMA',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_53,
  name: 'Brand Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_53,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_53,
  name: 'Visual Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_53,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_53,
  name: 'Creative Direction',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_53,
  position: 'Senior Brand Manager',
  company: 'General Motors',
  location: 'Arlington, TX',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive brand management initiatives for major organizations, developing brand strategies and visual identities that increased brand recognition by 45% and improved customer loyalty scores. Managed brand positioning and messaging development that differentiated clients in competitive markets and enhanced brand equity. Collaborated with creative teams to ensure consistent brand expression across all touchpoints and marketing channels.'
)

WorkExperienceItem.create(
  resume: resume_53,
  position: 'Brand Manager',
  company: 'General Motors',
  location: 'Arlington, TX',
  start_month: 7,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Managed brand development and positioning for various client organizations. Developed brand strategies and ensured consistent brand expression across marketing materials. Worked with creative teams to develop visual identities and brand guidelines.'
)

ExternalLinkItem.create(
  resume: resume_53,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate53'
)

ExternalLinkItem.create(
  resume: resume_53,
  name: 'Brand Portfolio',
  url: 'https://candidate53-brand-portfolio.com'
)

ReferenceItem.create(
  resume: resume_53,
  name: 'Christopher Lee',
  position: 'Brand Director',
  company: 'Brand Excellence Group',
  mobile: '+1 555 0053',
  kind: :job
)

ReferenceItem.create(
  resume: resume_53,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Brand Solutions',
  mobile: '+1 555 0053',
  kind: :personal
)

# Candidate 54
candidate_54 = Candidate.new(email: 'candidate_54@simplestresumes.com', password: password)
candidate_54.skip_confirmation!
candidate_54.save

resume_54 = Resume.create(
  candidate_id: candidate_54.id,
  name: 'Daniel Brown',
  email: candidate_54.email,
  mobile: '+1 555 0054',
  location: 'Corpus Christi, TX',
  about_me: 'Experienced project coordinator with expertise in team management and delivery optimization. I coordinate projects to ensure successful completion and stakeholder satisfaction.'
)

EducationItem.create(
  resume_id: resume_54.id,
  name: 'Project Management',
  institute: 'Texas A&M University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_54.id,
  name: 'PMP Certification',
  institute: 'Project Management Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_54,
  name: 'Project Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_54,
  name: 'Team Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_54,
  name: 'Delivery Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_54,
  name: 'Stakeholder Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_54,
  name: 'Risk Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_54,
  position: 'Senior Project Coordinator',
  company: 'General Motors',
  location: 'Corpus Christi, TX',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated complex projects with budgets exceeding $2M, ensuring successful delivery within scope, budget, and timeline constraints while maintaining high quality standards. Managed cross-functional project teams and coordinated resources to ensure project milestones were met and objectives achieved. Developed and maintained project schedules, coordinated stakeholder communications, and managed project risks to ensure successful outcomes.'
)

WorkExperienceItem.create(
  resume: resume_54,
  position: 'Project Coordinator',
  company: 'Project Solutions Pro',
  location: 'Corpus Christi, TX',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Coordinated project activities and supported project managers in delivering successful project outcomes. Managed project schedules and coordinated team resources. Assisted with stakeholder communications and project documentation.'
)

ExternalLinkItem.create(
  resume: resume_54,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate54'
)

ReferenceItem.create(
  resume: resume_54,
  name: 'Sarah Johnson',
  position: 'Project Director',
  company: 'Project Excellence Corp',
  mobile: '+1 555 0054',
  kind: :job
)

ReferenceItem.create(
  resume: resume_54,
  name: 'Robert Wilson',
  position: 'Senior PM',
  company: 'Project Solutions Pro',
  mobile: '+1 555 0054',
  kind: :personal
)

# Candidate 55
candidate_55 = Candidate.new(email: 'candidate_55@simplestresumes.com', password: password)
candidate_55.skip_confirmation!
candidate_55.save

resume_55 = Resume.create(
  candidate_id: candidate_55.id,
  name: 'Nicole Davis',
  email: candidate_55.email,
  mobile: '+1 555 0055',
  location: 'Raleigh, NC',
  about_me: 'Innovative UX designer with expertise in user research and interface design. I create intuitive user experiences that delight users and drive engagement.'
)

EducationItem.create(
  resume_id: resume_55.id,
  name: 'User Experience Design',
  institute: 'North Carolina State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_55.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_55,
  name: 'UX Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_55,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_55,
  name: 'Interface Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_55,
  name: 'Wireframing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_55,
  name: 'Prototyping',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_55,
  position: 'Senior UX Designer',
  company: 'UX Design Studio',
  location: 'Raleigh, NC',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led UX design initiatives for digital products serving millions of users, resulting in 50% improvement in user satisfaction scores and 35% reduction in user support requests. Conducted comprehensive user research including interviews, surveys, and usability testing to inform design decisions and validate solutions. Developed user personas, journey maps, and design systems that ensured consistent and intuitive user experiences across all product touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_55,
  position: 'UX Designer',
  company: 'Digital Experience Lab',
  location: 'Raleigh, NC',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Designed user interfaces and user experiences for web and mobile applications. Conducted user research and usability testing to inform design decisions. Created wireframes, prototypes, and design specifications for development teams.'
)

ExternalLinkItem.create(
  resume: resume_55,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate55'
)

ExternalLinkItem.create(
  resume: resume_55,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate55'
)

ReferenceItem.create(
  resume: resume_55,
  name: 'David Kim',
  position: 'UX Director',
  company: 'UX Design Studio',
  mobile: '+1 555 0055',
  kind: :job
)

ReferenceItem.create(
  resume: resume_55,
  name: 'Lisa Rodriguez',
  position: 'Design Manager',
  company: 'Digital Experience Lab',
  mobile: '+1 555 0055',
  kind: :personal
)

# Candidate 56
candidate_56 = Candidate.new(email: 'candidate_56@simplestresumes.com', password: password)
candidate_56.skip_confirmation!
candidate_56.save

resume_56 = Resume.create(
  candidate_id: candidate_56.id,
  name: 'James Johnson',
  email: candidate_56.email,
  mobile: '+1 555 0056',
  location: 'New Orleans, LA',
  about_me: 'Strategic business consultant with expertise in process improvement and organizational development. I help organizations optimize performance and achieve growth objectives.'
)

EducationItem.create(
  resume_id: resume_56.id,
  name: 'Business Administration',
  institute: 'Tulane University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_56.id,
  name: 'Management Consulting Certification',
  institute: 'McKinsey',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_56,
  name: 'Business Consulting',
  kind: :primary
)

SkillItem.create(
  resume: resume_56,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_56,
  name: 'Organizational Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_56,
  name: 'Change Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_56,
  name: 'Performance Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_56,
  position: 'Senior Business Consultant',
  company: 'Strategic Consulting Group',
  location: 'New Orleans, LA',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led strategic consulting engagements for Fortune 500 companies, delivering solutions that improved operational efficiency by 45% and increased profitability by 30%. Developed comprehensive business strategies and organizational development plans that supported long-term growth objectives. Managed client relationships and project teams, ensuring successful delivery of consulting services and measurable business outcomes.'
)

WorkExperienceItem.create(
  resume: resume_56,
  position: 'Business Consultant',
  company: 'Management Solutions Pro',
  location: 'New Orleans, LA',
  start_month: 6,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Provided business consulting services to various client organizations, analyzing business processes and developing improvement recommendations. Conducted organizational assessments and supported strategic planning initiatives. Worked with client teams to implement recommended changes and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_56,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate56'
)

ReferenceItem.create(
  resume: resume_56,
  name: 'Sarah Davis',
  position: 'Consulting Director',
  company: 'Strategic Consulting Group',
  mobile: '+1 555 0056',
  kind: :job
)

ReferenceItem.create(
  resume: resume_56,
  name: 'David Brown',
  position: 'Senior Consultant',
  company: 'Management Solutions Pro',
  mobile: '+1 555 0056',
  kind: :personal
)

# Candidate 57
candidate_57 = Candidate.new(email: 'candidate_57@simplestresumes.com', password: password)
candidate_57.skip_confirmation!
candidate_57.save

resume_57 = Resume.create(
  candidate_id: candidate_57.id,
  name: 'Stephanie Wilson',
  email: candidate_57.email,
  mobile: '+1 555 0057',
  location: 'Las Vegas, NV',
  about_me: 'Creative content strategist with expertise in storytelling and audience engagement. I develop content that connects with people and drives meaningful results.'
)

EducationItem.create(
  resume_id: resume_57.id,
  name: 'Communications',
  institute: 'University of Nevada',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_57.id,
  name: 'Content Strategy Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_57,
  name: 'Content Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_57,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_57,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_57,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_57,
  name: 'SEO',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_57,
  position: 'Senior Content Strategist',
  company: 'Content Strategy Pro',
  location: 'Las Vegas, NV',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content strategy initiatives for major brands and organizations, developing comprehensive content plans that increased audience engagement by 55% and improved brand recognition across multiple platforms. Created content strategies that aligned with business objectives and target audience preferences, ensuring consistent messaging and brand voice. Collaborated with creative teams to develop engaging content that effectively communicated brand messages and drove desired customer actions.'
)

WorkExperienceItem.create(
  resume: resume_57,
  position: 'Content Strategist',
  company: 'Creative Content Agency',
  location: 'Las Vegas, NV',
  start_month: 1,
  start_year: 2021,
  end_month: 6,
  end_year: 2022,
  description: 'Developed content strategies for client campaigns and managed content creation processes. Created engaging content for various platforms and conducted content performance analysis to optimize strategies. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_57,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate57'
)

ExternalLinkItem.create(
  resume: resume_57,
  name: 'Content Portfolio',
  url: 'https://candidate57-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_57,
  name: 'Robert Johnson',
  position: 'Content Director',
  company: 'Content Strategy Pro',
  mobile: '+1 555 0057',
  kind: :job
)

ReferenceItem.create(
  resume: resume_57,
  name: 'Michael Chen',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0057',
  kind: :personal
)

# Candidate 58
candidate_58 = Candidate.new(email: 'candidate_58@simplestresumes.com', password: password)
candidate_58.skip_confirmation!
candidate_58.save

resume_58 = Resume.create(
  candidate_id: candidate_58.id,
  name: 'Kevin Anderson',
  email: candidate_58.email,
  mobile: '+1 555 0058',
  location: 'Reno, NV',
  about_me: 'Experienced data scientist with expertise in machine learning and predictive analytics. I develop models that provide insights and drive data-driven decision making.'
)

EducationItem.create(
  resume_id: resume_58.id,
  name: 'Data Science',
  institute: 'University of Nevada',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_58.id,
  name: 'Machine Learning Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_58,
  name: 'Data Science',
  kind: :primary
)

SkillItem.create(
  resume: resume_58,
  name: 'Machine Learning',
  kind: :primary
)

SkillItem.create(
  resume: resume_58,
  name: 'Predictive Analytics',
  kind: :primary
)

SkillItem.create(
  resume: resume_58,
  name: 'Python',
  kind: :secondary
)

SkillItem.create(
  resume: resume_58,
  name: 'R',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_58,
  position: 'Senior Data Scientist',
  company: 'Data Science Lab',
  location: 'Reno, NV',
  start_month: 2,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data science initiatives that delivered actionable insights and predictive models for business decision-making, resulting in 25% improvement in operational efficiency and 20% increase in revenue. Developed machine learning models for customer segmentation, churn prediction, and demand forecasting that supported strategic business planning. Collaborated with business stakeholders to understand data needs and translate complex analytical findings into clear, actionable recommendations.'
)

WorkExperienceItem.create(
  resume: resume_58,
  position: 'Data Scientist',
  company: 'Analytics Solutions Inc',
  location: 'Reno, NV',
  start_month: 8,
  start_year: 2020,
  end_month: 1,
  end_year: 2022,
  description: 'Developed machine learning models and conducted data analysis to support business decision-making processes. Created predictive models and conducted statistical analysis to identify trends and opportunities. Worked with business teams to implement data-driven solutions and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_58,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate58'
)

ExternalLinkItem.create(
  resume: resume_58,
  name: 'GitHub',
  url: 'https://github.com/candidate58'
)

ReferenceItem.create(
  resume: resume_58,
  name: 'Rachel Green',
  position: 'Data Science Director',
  company: 'Data Science Lab',
  mobile: '+1 555 0058',
  kind: :job
)

ReferenceItem.create(
  resume: resume_58,
  name: 'Kevin Martinez',
  position: 'Senior Scientist',
  company: 'Analytics Solutions Inc',
  mobile: '+1 555 0058',
  kind: :personal
)

# Candidate 59
candidate_59 = Candidate.new(email: 'candidate_59@simplestresumes.com', password: password)
candidate_59.skip_confirmation!
candidate_59.save

resume_59 = Resume.create(
  candidate_id: candidate_59.id,
  name: 'Michelle Davis',
  email: candidate_59.email,
  mobile: '+1 555 0059',
  location: 'Henderson, NV',
  about_me: 'Strategic marketing manager with expertise in campaign development and brand growth. I develop marketing strategies that increase market share and customer engagement.'
)

EducationItem.create(
  resume_id: resume_59.id,
  name: 'Marketing',
  institute: 'University of Nevada',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_59.id,
  name: 'Digital Marketing Certification',
  institute: 'HubSpot Academy',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_59,
  name: 'Marketing Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_59,
  name: 'Campaign Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_59,
  name: 'Brand Growth',
  kind: :primary
)

SkillItem.create(
  resume: resume_59,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_59,
  name: 'Customer Engagement',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_59,
  position: 'Senior Marketing Manager',
  company: 'Strategic Marketing Group',
  location: 'Henderson, NV',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive marketing strategies for major brands, developing campaigns that increased market share by 35% and improved customer engagement by 50% across multiple channels. Managed integrated marketing campaigns from concept to execution, ensuring consistent messaging and optimal performance across all touchpoints. Conducted market research and competitive analysis to inform marketing decisions and identify opportunities for growth and market expansion.'
)

WorkExperienceItem.create(
  resume: resume_59,
  position: 'Marketing Manager',
  company: 'Marketing Solutions Pro',
  location: 'Henderson, NV',
  start_month: 3,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Developed marketing strategies for client campaigns and managed marketing initiatives across various channels. Conducted market research and competitive analysis to inform marketing decisions. Collaborated with creative teams to develop marketing materials and ensure brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_59,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate59'
)

ExternalLinkItem.create(
  resume: resume_59,
  name: 'Marketing Blog',
  url: 'https://candidate59-marketing-blog.com'
)

ReferenceItem.create(
  resume: resume_59,
  name: 'Christopher Lee',
  position: 'Marketing Director',
  company: 'Strategic Marketing Group',
  mobile: '+1 555 0059',
  kind: :job
)

ReferenceItem.create(
  resume: resume_59,
  name: 'Jennifer Davis',
  position: 'Brand Manager',
  company: 'Marketing Solutions Pro',
  mobile: '+1 555 0059',
  kind: :personal
)

# Candidate 60
candidate_60 = Candidate.new(email: 'candidate_60@simplestresumes.com', password: password)
candidate_60.skip_confirmation!
candidate_60.save

resume_60 = Resume.create(
  candidate_id: candidate_60.id,
  name: 'Andrew Wilson',
  email: candidate_60.email,
  mobile: '+1 555 0060',
  location: 'Greensboro, NC',
  about_me: 'Innovative product strategist with expertise in market analysis and product development. I develop strategies that create competitive advantages and drive market success.'
)

EducationItem.create(
  resume_id: resume_60.id,
  name: 'Product Strategy',
  institute: 'University of North Carolina',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_60.id,
  name: 'Product Strategy Certification',
  institute: 'Product School',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_60,
  name: 'Product Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_60,
  name: 'Market Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_60,
  name: 'Product Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_60,
  name: 'Competitive Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_60,
  name: 'Strategic Planning',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_60,
  position: 'Senior Product Strategist',
  company: 'Product Strategy Group',
  location: 'Greensboro, NC',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy initiatives for major organizations, developing comprehensive strategies that created competitive advantages and drove market success. Conducted market analysis and competitive research to identify opportunities and inform product development decisions. Collaborated with product and business teams to develop strategic roadmaps that aligned with business objectives and market opportunities.'
)

WorkExperienceItem.create(
  resume: resume_60,
  position: 'Product Strategist',
  company: 'Strategic Products Inc',
  location: 'Greensboro, NC',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Developed product strategies and conducted market analysis to inform product development decisions. Conducted competitive analysis and market research to identify opportunities. Worked with product teams to develop strategic roadmaps and ensure alignment with business objectives.'
)

ExternalLinkItem.create(
  resume: resume_60,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate60'
)

ExternalLinkItem.create(
  resume: resume_60,
  name: 'Strategy Portfolio',
  url: 'https://candidate60-strategy-portfolio.com'
)

ReferenceItem.create(
  resume: resume_60,
  name: 'Jessica Taylor',
  position: 'Product Strategy Director',
  company: 'Product Strategy Group',
  mobile: '+1 555 0060',
  kind: :job
)

ReferenceItem.create(
  resume: resume_60,
  name: 'Mark Johnson',
  position: 'Strategy Manager',
  company: 'Strategic Products Inc',
  mobile: '+1 555 0060',
  kind: :personal
)

# Candidate 61
candidate_61 = Candidate.new(email: 'candidate_61@simplestresumes.com', password: password)
candidate_61.skip_confirmation!
candidate_61.save

resume_61 = Resume.create(
  candidate_id: candidate_61.id,
  name: 'Lisa Rodriguez',
  email: candidate_61.email,
  mobile: '+1 555 0061',
  location: 'Wichita, KS',
  about_me: 'Creative graphic designer with expertise in visual communication and brand identity. I create compelling designs that effectively communicate messages and enhance brand recognition.'
)

EducationItem.create(
  resume_id: resume_61.id,
  name: 'Graphic Design',
  institute: 'Wichita State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_61.id,
  name: 'Adobe Creative Suite Certification',
  institute: 'Adobe',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_61,
  name: 'Graphic Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_61,
  name: 'Visual Communication',
  kind: :primary
)

SkillItem.create(
  resume: resume_61,
  name: 'Brand Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_61,
  name: 'Typography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_61,
  name: 'Layout Design',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_61,
  position: 'Senior Graphic Designer',
  company: 'Creative Design Studio',
  location: 'Wichita, KS',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led creative design projects for major brands and organizations, developing visual identities and marketing materials that increased brand recognition by 45% and improved customer engagement. Managed design teams and creative processes, ensuring high-quality deliverables that met client objectives and brand guidelines. Collaborated with marketing teams to develop cohesive visual strategies that supported business goals and enhanced brand presence.'
)

WorkExperienceItem.create(
  resume: resume_61,
  position: 'Graphic Designer',
  company: 'Visual Design Agency',
  location: 'Wichita, KS',
  start_month: 2,
  start_year: 2021,
  end_month: 7,
  end_year: 2022,
  description: 'Created graphic designs for various client projects including logos, marketing materials, and digital assets. Worked with creative teams to develop visual concepts and ensure brand consistency. Managed multiple design projects and met client deadlines.'
)

ExternalLinkItem.create(
  resume: resume_61,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate61'
)

ExternalLinkItem.create(
  resume: resume_61,
  name: 'Behance',
  url: 'https://behance.net/candidate61'
)

ReferenceItem.create(
  resume: resume_61,
  name: 'Michael Rodriguez',
  position: 'Creative Director',
  company: 'Creative Design Studio',
  mobile: '+1 555 0061',
  kind: :job
)

ReferenceItem.create(
  resume: resume_61,
  name: 'Sarah Kim',
  position: 'Design Manager',
  company: 'Visual Design Agency',
  mobile: '+1 555 0061',
  kind: :personal
)

# Candidate 62
candidate_62 = Candidate.new(email: 'candidate_62@simplestresumes.com', password: password)
candidate_62.skip_confirmation!
candidate_62.save

resume_62 = Resume.create(
  candidate_id: candidate_62.id,
  name: 'Robert Wilson',
  email: candidate_62.email,
  mobile: '+1 555 0062',
  location: 'Anchorage, AK',
  about_me: 'Strategic business analyst with expertise in process optimization and data-driven decision making. I help organizations improve efficiency and achieve operational excellence.'
)

EducationItem.create(
  resume_id: resume_62.id,
  name: 'Business Analysis',
  institute: 'University of Alaska',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_62.id,
  name: 'Six Sigma Green Belt',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_62,
  name: 'Business Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_62,
  name: 'Process Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_62,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_62,
  name: 'Requirements Gathering',
  kind: :secondary
)

SkillItem.create(
  resume: resume_62,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_62,
  position: 'Senior Business Analyst',
  company: 'Business Optimization Group',
  location: 'Anchorage, AK',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business analysis initiatives that identified and implemented process improvements resulting in 35% reduction in operational costs and 45% improvement in process efficiency. Conducted comprehensive business process analysis and developed recommendations for optimization that supported organizational goals and improved customer experience. Managed stakeholder relationships and facilitated workshops to gather requirements and ensure alignment on business objectives.'
)

WorkExperienceItem.create(
  resume: resume_62,
  position: 'Business Analyst',
  company: 'Process Solutions Inc',
  location: 'Anchorage, AK',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Analyzed business processes and gathered requirements for system improvements and process optimization projects. Created business process documentation and worked with stakeholders to ensure accurate requirement definition. Supported project teams in implementing process improvements and system enhancements.'
)

ExternalLinkItem.create(
  resume: resume_62,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate62'
)

ReferenceItem.create(
  resume: resume_62,
  name: 'Amanda Rodriguez',
  position: 'Business Analysis Director',
  company: 'Business Optimization Group',
  mobile: '+1 555 0062',
  kind: :job
)

ReferenceItem.create(
  resume: resume_62,
  name: 'Carlos Mendez',
  position: 'Process Manager',
  company: 'Process Solutions Inc',
  mobile: '+1 555 0062',
  kind: :personal
)

# Candidate 63
candidate_63 = Candidate.new(email: 'candidate_63@simplestresumes.com', password: password)
candidate_63.skip_confirmation!
candidate_63.save

resume_63 = Resume.create(
  candidate_id: candidate_63.id,
  name: 'Jennifer Davis',
  email: candidate_63.email,
  mobile: '+1 555 0063',
  location: 'Honolulu, HI',
  about_me: 'Creative marketing coordinator with expertise in campaign execution and brand management. I coordinate marketing efforts that drive results and enhance brand presence.'
)

EducationItem.create(
  resume_id: resume_63.id,
  name: 'Marketing',
  institute: 'University of Hawaii',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_63.id,
  name: 'Digital Marketing Certification',
  institute: 'Google Digital Garage',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_63,
  name: 'Campaign Execution',
  kind: :primary
)

SkillItem.create(
  resume: resume_63,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_63,
  name: 'Marketing Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_63,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_63,
  name: 'Social Media',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_63,
  position: 'Senior Marketing Coordinator',
  company: 'Marketing Excellence Corp',
  location: 'Honolulu, HI',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated comprehensive marketing campaigns for major brands, managing multiple channels and ensuring consistent messaging that increased brand awareness by 40% and improved customer engagement. Developed and executed marketing strategies that aligned with business objectives and target audience preferences. Coordinated with creative teams, media partners, and stakeholders to ensure successful campaign delivery and measurable results.'
)

WorkExperienceItem.create(
  resume: resume_63,
  position: 'Marketing Coordinator',
  company: 'Creative Marketing Solutions',
  location: 'Honolulu, HI',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Coordinated marketing campaigns and supported brand management initiatives for various client accounts. Assisted with content creation and social media management. Coordinated with creative teams and ensured campaign deliverables met quality standards.'
)

ExternalLinkItem.create(
  resume: resume_63,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate63'
)

ExternalLinkItem.create(
  resume: resume_63,
  name: 'Marketing Portfolio',
  url: 'https://candidate63-marketing-portfolio.com'
)

ReferenceItem.create(
  resume: resume_63,
  name: 'Michael Chen',
  position: 'Marketing Director',
  company: 'Marketing Excellence Corp',
  mobile: '+1 555 0063',
  kind: :job
)

ReferenceItem.create(
  resume: resume_63,
  name: 'Lisa Rodriguez',
  position: 'Brand Manager',
  company: 'Creative Marketing Solutions',
  mobile: '+1 555 0063',
  kind: :personal
)

# Candidate 64
candidate_64 = Candidate.new(email: 'candidate_64@simplestresumes.com', password: password)
candidate_64.skip_confirmation!
candidate_64.save

resume_64 = Resume.create(
  candidate_id: candidate_64.id,
  name: 'David Brown',
  email: candidate_64.email,
  mobile: '+1 555 0064',
  location: 'Boise, ID',
  about_me: 'Experienced project coordinator with expertise in team coordination and project delivery. I ensure projects are completed on time and within budget through effective coordination.'
)

EducationItem.create(
  resume_id: resume_64.id,
  name: 'Project Management',
  institute: 'Boise State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_64.id,
  name: 'Agile Certification',
  institute: 'Scrum Alliance',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_64,
  name: 'Project Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_64,
  name: 'Team Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_64,
  name: 'Project Delivery',
  kind: :primary
)

SkillItem.create(
  resume: resume_64,
  name: 'Schedule Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_64,
  name: 'Resource Allocation',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_64,
  position: 'Senior Project Coordinator',
  company: 'Project Excellence Group',
  location: 'Boise, ID',
  start_month: 10,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated complex projects with budgets exceeding $1.5M, ensuring successful delivery within scope, budget, and timeline constraints while maintaining high quality standards. Managed cross-functional project teams and coordinated resources to ensure project milestones were met and objectives achieved. Developed and maintained project schedules, coordinated stakeholder communications, and managed project risks to ensure successful outcomes.'
)

WorkExperienceItem.create(
  resume: resume_64,
  position: 'Project Coordinator',
  company: 'Project Solutions Pro',
  location: 'Boise, ID',
  start_month: 3,
  start_year: 2021,
  end_month: 9,
  end_year: 2022,
  description: 'Coordinated project activities and supported project managers in delivering successful project outcomes. Managed project schedules and coordinated team resources. Assisted with stakeholder communications and project documentation.'
)

ExternalLinkItem.create(
  resume: resume_64,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate64'
)

ReferenceItem.create(
  resume: resume_64,
  name: 'Sarah Johnson',
  position: 'Project Director',
  company: 'Project Excellence Group',
  mobile: '+1 555 0064',
  kind: :job
)

ReferenceItem.create(
  resume: resume_64,
  name: 'Robert Wilson',
  position: 'Senior PM',
  company: 'Project Solutions Pro',
  mobile: '+1 555 0064',
  kind: :personal
)

# Candidate 65
candidate_65 = Candidate.new(email: 'candidate_65@simplestresumes.com', password: password)
candidate_65.skip_confirmation!
candidate_65.save

resume_65 = Resume.create(
  candidate_id: candidate_65.id,
  name: 'Lisa Anderson',
  email: candidate_65.email,
  mobile: '+1 555 0065',
  location: 'Des Moines, IA',
  about_me: 'Innovative web developer with expertise in front-end development and user experience. I create responsive websites that provide excellent user experiences and drive engagement.'
)

EducationItem.create(
  resume_id: resume_65.id,
  name: 'Web Development',
  institute: 'Iowa State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_65.id,
  name: 'React Certification',
  institute: 'Meta',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_65,
  name: 'Front-end Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_65,
  name: 'Web Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_65,
  name: 'User Experience',
  kind: :primary
)

SkillItem.create(
  resume: resume_65,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_65,
  name: 'CSS',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_65,
  position: 'Senior Web Developer',
  company: 'Web Development Studio',
  location: 'Des Moines, IA',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led web development projects for major clients, creating responsive websites and web applications that improved user engagement by 50% and enhanced online presence. Developed front-end solutions using modern technologies and best practices that ensured optimal performance and user experience. Collaborated with design and back-end teams to deliver cohesive web solutions that met client requirements and exceeded expectations.'
)

WorkExperienceItem.create(
  resume: resume_65,
  position: 'Web Developer',
  company: 'Digital Web Solutions',
  location: 'Des Moines, IA',
  start_month: 12,
  start_year: 2020,
  end_month: 6,
  end_year: 2022,
  description: 'Developed websites and web applications for various client projects. Created responsive designs and ensured cross-browser compatibility. Worked with design teams to implement visual designs and maintain code quality.'
)

ExternalLinkItem.create(
  resume: resume_65,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate65'
)

ExternalLinkItem.create(
  resume: resume_65,
  name: 'GitHub',
  url: 'https://github.com/candidate65'
)

ReferenceItem.create(
  resume: resume_65,
  name: 'Christopher Lee',
  position: 'Development Director',
  company: 'Web Development Studio',
  mobile: '+1 555 0065',
  kind: :job
)

ReferenceItem.create(
  resume: resume_65,
  name: 'David Kim',
  position: 'Senior Developer',
  company: 'Digital Web Solutions',
  mobile: '+1 555 0065',
  kind: :personal
)

# Candidate 66
candidate_66 = Candidate.new(email: 'candidate_66@simplestresumes.com', password: password)
candidate_66.skip_confirmation!
candidate_66.save

resume_66 = Resume.create(
  candidate_id: candidate_66.id,
  name: 'Michael Rodriguez',
  email: candidate_66.email,
  mobile: '+1 555 0066',
  location: 'Springfield, IL',
  about_me: 'Strategic operations analyst with expertise in performance optimization and process improvement. I analyze operations to identify opportunities for enhancement and efficiency gains.'
)

EducationItem.create(
  resume_id: resume_66.id,
  name: 'Operations Management',
  institute: 'University of Illinois',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_66.id,
  name: 'Lean Six Sigma Certification',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_66,
  name: 'Operations Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_66,
  name: 'Performance Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_66,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_66,
  name: 'Data Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_66,
  name: 'Performance Metrics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_66,
  position: 'Senior Operations Analyst',
  company: 'Operations Excellence Corp',
  location: 'Springfield, IL',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led operations analysis initiatives that identified and implemented performance improvements resulting in 30% increase in operational efficiency and 25% reduction in costs while maintaining quality standards. Conducted comprehensive performance analysis and developed optimization strategies that supported organizational goals and improved customer satisfaction. Managed performance metrics and reporting systems that provided insights for continuous improvement and strategic decision-making.'
)

WorkExperienceItem.create(
  resume: resume_66,
  position: 'Operations Analyst',
  company: 'Performance Solutions Inc',
  location: 'Springfield, IL',
  start_month: 6,
  start_year: 2021,
  end_month: 12,
  end_year: 2021,
  description: 'Analyzed operational performance and identified opportunities for improvement and optimization. Developed performance metrics and reporting systems to support operational decision-making. Supported process improvement initiatives and performance optimization projects.'
)

ExternalLinkItem.create(
  resume: resume_66,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate66'
)

ReferenceItem.create(
  resume: resume_66,
  name: 'Jennifer Wilson',
  position: 'Operations Director',
  company: 'Operations Excellence Corp',
  mobile: '+1 555 0066',
  kind: :job
)

ReferenceItem.create(
  resume: resume_66,
  name: 'Robert Brown',
  position: 'Performance Manager',
  company: 'Performance Solutions Inc',
  mobile: '+1 555 0066',
  kind: :personal
)

# Candidate 67
candidate_67 = Candidate.new(email: 'candidate_67@simplestresumes.com', password: password)
candidate_67.skip_confirmation!
candidate_67.save

resume_67 = Resume.create(
  candidate_id: candidate_67.id,
  name: 'Sarah Johnson',
  email: candidate_67.email,
  mobile: '+1 555 0067',
  location: 'Indianapolis, IN',
  about_me: 'Creative content creator with expertise in storytelling and audience engagement. I develop compelling content that connects with audiences and drives meaningful engagement.'
)

EducationItem.create(
  resume_id: resume_67.id,
  name: 'Communications',
  institute: 'Indiana University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_67.id,
  name: 'Content Creation Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_67,
  name: 'Content Creation',
  kind: :primary
)

SkillItem.create(
  resume: resume_67,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_67,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_67,
  name: 'Content Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_67,
  name: 'Creative Writing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_67,
  position: 'Senior Content Creator',
  company: 'Content Creation Studio',
  location: 'Indianapolis, IN',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content creation initiatives for major brands and organizations, developing compelling content that increased audience engagement by 55% and improved brand recognition across multiple platforms. Created diverse content types including articles, videos, and social media posts that effectively communicated brand messages and engaged target audiences. Collaborated with marketing teams to develop content strategies that aligned with business objectives and audience preferences.'
)

WorkExperienceItem.create(
  resume: resume_67,
  position: 'Content Creator',
  company: 'Creative Content Agency',
  location: 'Indianapolis, IN',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Created engaging content for various client campaigns and platforms. Developed content strategies and created diverse content types to support marketing objectives. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_67,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate67'
)

ExternalLinkItem.create(
  resume: resume_67,
  name: 'Content Portfolio',
  url: 'https://candidate67-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_67,
  name: 'David Chen',
  position: 'Content Director',
  company: 'Content Creation Studio',
  mobile: '+1 555 0067',
  kind: :job
)

ReferenceItem.create(
  resume: resume_67,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0067',
  kind: :personal
)

# Candidate 68
candidate_68 = Candidate.new(email: 'candidate_68@simplestresumes.com', password: password)
candidate_68.skip_confirmation!
candidate_68.save

resume_68 = Resume.create(
  candidate_id: candidate_68.id,
  name: 'Christopher Lee',
  email: candidate_68.email,
  mobile: '+1 555 0068',
  location: 'Louisville, KY',
  about_me: 'Experienced data analyst with expertise in statistical analysis and business intelligence. I transform data into actionable insights that support strategic decision-making.'
)

EducationItem.create(
  resume_id: resume_68.id,
  name: 'Data Science',
  institute: 'University of Louisville',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_68.id,
  name: 'Statistical Analysis Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_68,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_68,
  name: 'Statistical Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_68,
  name: 'Business Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_68,
  name: 'Data Visualization',
  kind: :secondary
)

SkillItem.create(
  resume: resume_68,
  name: 'SQL',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_68,
  position: 'Senior Data Analyst',
  company: 'Data Analytics Group',
  location: 'Louisville, KY',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data analysis initiatives that provided critical insights for strategic decision-making, supporting business growth initiatives that increased revenue by 30% and improved operational efficiency by 25%. Conducted comprehensive statistical analysis and developed predictive models that identified trends and opportunities for business optimization. Created data visualizations and reports that effectively communicated complex analytical findings to stakeholders and supported data-driven decision-making.'
)

WorkExperienceItem.create(
  resume: resume_68,
  position: 'Data Analyst',
  company: 'Analytics Solutions Pro',
  location: 'Louisville, KY',
  start_month: 1,
  start_year: 2021,
  end_month: 7,
  end_year: 2022,
  description: 'Analyzed business data and conducted statistical analysis to support decision-making processes. Created data visualizations and reports that communicated insights to stakeholders. Supported business intelligence initiatives and data-driven decision-making.'
)

ExternalLinkItem.create(
  resume: resume_68,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate68'
)

ExternalLinkItem.create(
  resume: resume_68,
  name: 'GitHub',
  url: 'https://github.com/candidate68'
)

ReferenceItem.create(
  resume: resume_68,
  name: 'Amanda Rodriguez',
  position: 'Analytics Director',
  company: 'Data Analytics Group',
  mobile: '+1 555 0068',
  kind: :job
)

ReferenceItem.create(
  resume: resume_68,
  name: 'Michael Chen',
  position: 'Senior Analyst',
  company: 'Analytics Solutions Pro',
  mobile: '+1 555 0068',
  kind: :personal
)

# Candidate 69
candidate_69 = Candidate.new(email: 'candidate_69@simplestresumes.com', password: password)
candidate_69.skip_confirmation!
candidate_69.save

resume_69 = Resume.create(
  candidate_id: candidate_69.id,
  name: 'Nicole Wilson',
  email: candidate_69.email,
  mobile: '+1 555 0069',
  location: 'Baton Rouge, LA',
  about_me: 'Innovative product manager with expertise in agile methodologies and user-centered design. I deliver products that solve real problems and create meaningful user experiences.'
)

EducationItem.create(
  resume_id: resume_69.id,
  name: 'Product Management',
  institute: 'Louisiana State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_69.id,
  name: 'Agile Scrum Master',
  institute: 'Scrum Alliance',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_69,
  name: 'Product Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_69,
  name: 'Agile Methodologies',
  kind: :primary
)

SkillItem.create(
  resume: resume_69,
  name: 'User-Centered Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_69,
  name: 'Product Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_69,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_69,
  position: 'Senior Product Manager',
  company: 'Product Innovation Corp',
  location: 'Baton Rouge, LA',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy and development for a portfolio of digital products serving over 150,000 users, resulting in 40% increase in user engagement and 30% improvement in customer satisfaction scores. Managed cross-functional product teams using agile methodologies, ensuring timely delivery of high-quality products that met user needs and business objectives. Conducted user research and market analysis to inform product decisions and prioritize feature development.'
)

WorkExperienceItem.create(
  resume: resume_69,
  position: 'Product Manager',
  company: 'Digital Products Solutions',
  location: 'Baton Rouge, LA',
  start_month: 8,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Managed product development lifecycle for multiple digital products, working with development teams to deliver features and improvements. Conducted user research and gathered feedback to inform product decisions and prioritize development efforts. Collaborated with stakeholders to define product requirements and ensure successful product launches.'
)

ExternalLinkItem.create(
  resume: resume_69,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate69'
)

ExternalLinkItem.create(
  resume: resume_69,
  name: 'Product Blog',
  url: 'https://candidate69-product-blog.com'
)

ReferenceItem.create(
  resume: resume_69,
  name: 'Jessica Taylor',
  position: 'VP of Product',
  company: 'Product Innovation Corp',
  mobile: '+1 555 0069',
  kind: :job
)

ReferenceItem.create(
  resume: resume_69,
  name: 'Mark Johnson',
  position: 'Product Director',
  company: 'Digital Products Solutions',
  mobile: '+1 555 0069',
  kind: :personal
)

# Candidate 70
candidate_70 = Candidate.new(email: 'candidate_70@simplestresumes.com', password: password)
candidate_70.skip_confirmation!
candidate_70.save

resume_70 = Resume.create(
  candidate_id: candidate_70.id,
  name: 'Andrew Davis',
  email: candidate_70.email,
  mobile: '+1 555 0070',
  location: 'Portland, ME',
  about_me: 'Strategic business development professional with expertise in market expansion and partnership development. I identify opportunities and build strategic relationships.'
)

EducationItem.create(
  resume_id: resume_70.id,
  name: 'Business Development',
  institute: 'University of Maine',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_70.id,
  name: 'Strategic Partnerships Certification',
  institute: 'Business Development Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_70,
  name: 'Business Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_70,
  name: 'Market Expansion',
  kind: :primary
)

SkillItem.create(
  resume: resume_70,
  name: 'Partnership Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_70,
  name: 'Strategic Planning',
  kind: :secondary
)

SkillItem.create(
  resume: resume_70,
  name: 'Relationship Building',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_70,
  position: 'Senior Business Development Manager',
  company: 'Business Growth Partners',
  location: 'Portland, ME',
  start_month: 11,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business development initiatives that expanded market presence into 6 new territories and established strategic partnerships that generated $15M in additional revenue. Developed and executed market expansion strategies that identified new opportunities and positioned the company for sustainable growth in emerging markets. Built and maintained relationships with key partners, clients, and stakeholders that supported business objectives and created new revenue streams.'
)

WorkExperienceItem.create(
  resume: resume_70,
  position: 'Business Development Manager',
  company: 'Strategic Partnerships Inc',
  location: 'Portland, ME',
  start_month: 5,
  start_year: 2021,
  end_month: 10,
  end_year: 2022,
  description: 'Identified new business opportunities and developed strategies for market expansion and growth. Built relationships with potential partners and clients to support business development objectives. Conducted market research and analysis to inform business development strategies.'
)

ExternalLinkItem.create(
  resume: resume_70,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate70'
)

ReferenceItem.create(
  resume: resume_70,
  name: 'David Thompson',
  position: 'Business Development Director',
  company: 'Business Growth Partners',
  mobile: '+1 555 0070',
  kind: :job
)

ReferenceItem.create(
  resume: resume_70,
  name: 'Lisa Anderson',
  position: 'Partnership Manager',
  company: 'Strategic Partnerships Inc',
  mobile: '+1 555 0070',
  kind: :personal
)

# Candidate 71
candidate_71 = Candidate.new(email: 'candidate_71@simplestresumes.com', password: password)
candidate_71.skip_confirmation!
candidate_71.save

resume_71 = Resume.create(
  candidate_id: candidate_71.id,
  name: 'Michelle Johnson',
  email: candidate_71.email,
  mobile: '+1 555 0071',
  location: 'Baltimore, MD',
  about_me: 'Creative UX researcher with expertise in user behavior analysis and usability testing. I uncover insights that inform design decisions and improve user experiences.'
)

EducationItem.create(
  resume_id: resume_71.id,
  name: 'User Experience Research',
  institute: 'University of Maryland',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_71.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_71,
  name: 'UX Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_71,
  name: 'User Behavior Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_71,
  name: 'Usability Testing',
  kind: :primary
)

SkillItem.create(
  resume: resume_71,
  name: 'Data Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_71,
  name: 'Research Methods',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_71,
  position: 'Senior UX Researcher',
  company: 'UX Research Studio',
  location: 'Baltimore, MD',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive UX research initiatives for digital products serving millions of users, conducting studies that provided critical insights for design decisions and improved user satisfaction scores by 45%. Designed and executed research studies including user interviews, surveys, and usability testing that identified user needs and pain points. Collaborated with design and product teams to translate research findings into actionable design recommendations and product improvements.'
)

WorkExperienceItem.create(
  resume: resume_71,
  position: 'UX Researcher',
  company: 'User Experience Lab',
  location: 'Baltimore, MD',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Conducted UX research studies and usability testing for various digital products and applications. Analyzed user behavior and provided insights to inform design decisions. Worked with design teams to ensure user needs were addressed in product development.'
)

ExternalLinkItem.create(
  resume: resume_71,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate71'
)

ExternalLinkItem.create(
  resume: resume_71,
  name: 'Research Portfolio',
  url: 'https://candidate71-research-portfolio.com'
)

ReferenceItem.create(
  resume: resume_71,
  name: 'Emily Garcia',
  position: 'UX Research Director',
  company: 'UX Research Studio',
  mobile: '+1 555 0071',
  kind: :job
)

ReferenceItem.create(
  resume: resume_71,
  name: 'David Kim',
  position: 'Design Manager',
  company: 'User Experience Lab',
  mobile: '+1 555 0071',
  kind: :personal
)

# Candidate 72
candidate_72 = Candidate.new(email: 'candidate_72@simplestresumes.com', password: password)
candidate_72.skip_confirmation!
candidate_72.save

resume_72 = Resume.create(
  candidate_id: candidate_72.id,
  name: 'Jessica Taylor',
  email: candidate_72.email,
  mobile: '+1 555 0072',
  location: 'Boston, MA',
  about_me: 'Strategic marketing analyst with expertise in campaign performance and data-driven insights. I analyze marketing data to optimize campaigns and improve ROI.'
)

EducationItem.create(
  resume_id: resume_72.id,
  name: 'Marketing Analytics',
  institute: 'Boston University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_72.id,
  name: 'Google Analytics Certification',
  institute: 'Google',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_72,
  name: 'Marketing Analytics',
  kind: :primary
)

SkillItem.create(
  resume: resume_72,
  name: 'Campaign Performance',
  kind: :primary
)

SkillItem.create(
  resume: resume_72,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_72,
  name: 'ROI Optimization',
  kind: :secondary
)

SkillItem.create(
  resume: resume_72,
  name: 'Performance Metrics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_72,
  position: 'Senior Marketing Analyst',
  company: 'Marketing Analytics Group',
  location: 'Boston, MA',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led marketing analytics initiatives that provided critical insights for campaign optimization, resulting in 40% improvement in ROI and 35% increase in campaign performance across multiple channels. Analyzed campaign data and performance metrics to identify optimization opportunities and develop data-driven recommendations. Created comprehensive reports and dashboards that provided actionable insights for marketing teams and supported strategic decision-making.'
)

WorkExperienceItem.create(
  resume: resume_72,
  position: 'Marketing Analyst',
  company: 'Campaign Analytics Pro',
  location: 'Boston, MA',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Analyzed marketing campaign performance and provided insights to optimize marketing strategies. Created performance reports and dashboards for various marketing channels. Supported marketing teams with data analysis and performance optimization recommendations.'
)

ExternalLinkItem.create(
  resume: resume_72,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate72'
)

ExternalLinkItem.create(
  resume: resume_72,
  name: 'Analytics Portfolio',
  url: 'https://candidate72-analytics-portfolio.com'
)

ReferenceItem.create(
  resume: resume_72,
  name: 'David Wilson',
  position: 'Marketing Analytics Director',
  company: 'Marketing Analytics Group',
  mobile: '+1 555 0072',
  kind: :job
)

ReferenceItem.create(
  resume: resume_72,
  name: 'Sarah Johnson',
  position: 'Senior Analyst',
  company: 'Campaign Analytics Pro',
  mobile: '+1 555 0072',
  kind: :personal
)

# Candidate 73
candidate_73 = Candidate.new(email: 'candidate_73@simplestresumes.com', password: password)
candidate_73.skip_confirmation!
candidate_73.save

resume_73 = Resume.create(
  candidate_id: candidate_73.id,
  name: 'Ryan Johnson',
  email: candidate_73.email,
  mobile: '+1 555 0073',
  location: 'Detroit, MI',
  about_me: 'Innovative software engineer with expertise in full-stack development and system architecture. I build robust applications that solve complex problems efficiently.'
)

EducationItem.create(
  resume_id: resume_73.id,
  name: 'Computer Science',
  institute: 'University of Michigan',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_73.id,
  name: 'Full-Stack Development Certification',
  institute: 'Udemy',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_73,
  name: 'Full-Stack Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_73,
  name: 'Software Engineering',
  kind: :primary
)

SkillItem.create(
  resume: resume_73,
  name: 'System Architecture',
  kind: :primary
)

SkillItem.create(
  resume: resume_73,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_73,
  name: 'Python',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_73,
  position: 'Senior Software Engineer',
  company: 'Tech Solutions Corp',
  location: 'Detroit, MI',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led full-stack development initiatives for enterprise applications serving over 200,000 users, implementing scalable solutions that improved system performance by 50% and reduced development time by 30%. Designed and developed system architectures that enhanced application reliability and enabled rapid feature development. Collaborated with cross-functional teams to deliver high-quality software solutions that met business requirements and exceeded user expectations.'
)

WorkExperienceItem.create(
  resume: resume_73,
  position: 'Software Engineer',
  company: 'Digital Development Lab',
  location: 'Detroit, MI',
  start_month: 12,
  start_year: 2020,
  end_month: 7,
  end_year: 2022,
  description: 'Developed full-stack applications and software solutions for various client projects. Implemented system architectures and ensured code quality and performance. Worked with development teams to deliver software solutions that met client requirements.'
)

ExternalLinkItem.create(
  resume: resume_73,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate73'
)

ExternalLinkItem.create(
  resume: resume_73,
  name: 'GitHub',
  url: 'https://github.com/candidate73'
)

ReferenceItem.create(
  resume: resume_73,
  name: 'Jennifer Lee',
  position: 'Engineering Director',
  company: 'Tech Solutions Corp',
  mobile: '+1 555 0073',
  kind: :job
)

ReferenceItem.create(
  resume: resume_73,
  name: 'Michael Chen',
  position: 'Senior Engineer',
  company: 'Digital Development Lab',
  mobile: '+1 555 0073',
  kind: :personal
)

# Candidate 74
candidate_74 = Candidate.new(email: 'candidate_74@simplestresumes.com', password: password)
candidate_74.skip_confirmation!
candidate_74.save

resume_74 = Resume.create(
  candidate_id: candidate_74.id,
  name: 'Amanda Wilson',
  email: candidate_74.email,
  mobile: '+1 555 0074',
  location: 'Minneapolis, MN',
  about_me: 'Creative brand manager with expertise in brand strategy and visual identity. I develop comprehensive brand systems that strengthen market presence and customer loyalty.'
)

EducationItem.create(
  resume_id: resume_74.id,
  name: 'Brand Management',
  institute: 'University of Minnesota',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_74.id,
  name: 'Brand Strategy Certification',
  institute: 'AMA',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_74,
  name: 'Brand Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_74,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_74,
  name: 'Visual Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_74,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_74,
  name: 'Creative Direction',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_74,
  position: 'Senior Brand Manager',
  company: 'Brand Excellence Group',
  location: 'Minneapolis, MN',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive brand management initiatives for major organizations, developing brand strategies and visual identities that increased brand recognition by 45% and improved customer loyalty scores. Managed brand positioning and messaging development that differentiated clients in competitive markets and enhanced brand equity. Collaborated with creative teams to ensure consistent brand expression across all touchpoints and marketing channels.'
)

WorkExperienceItem.create(
  resume: resume_74,
  position: 'Brand Manager',
  company: 'Creative Brand Solutions',
  location: 'Minneapolis, MN',
  start_month: 7,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Managed brand development and positioning for various client organizations. Developed brand strategies and ensured consistent brand expression across marketing materials. Worked with creative teams to develop visual identities and brand guidelines.'
)

ExternalLinkItem.create(
  resume: resume_74,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate74'
)

ExternalLinkItem.create(
  resume: resume_74,
  name: 'Brand Portfolio',
  url: 'https://candidate74-brand-portfolio.com'
)

ReferenceItem.create(
  resume: resume_74,
  name: 'Christopher Lee',
  position: 'Brand Director',
  company: 'Brand Excellence Group',
  mobile: '+1 555 0074',
  kind: :job
)

ReferenceItem.create(
  resume: resume_74,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Brand Solutions',
  mobile: '+1 555 0074',
  kind: :personal
)

# Candidate 75
candidate_75 = Candidate.new(email: 'candidate_75@simplestresumes.com', password: password)
candidate_75.skip_confirmation!
candidate_75.save

resume_75 = Resume.create(
  candidate_id: candidate_75.id,
  name: 'Daniel Brown',
  email: candidate_75.email,
  mobile: '+1 555 0075',
  location: 'Jackson, MS',
  about_me: 'Experienced project coordinator with expertise in team management and delivery optimization. I coordinate projects to ensure successful completion and stakeholder satisfaction.'
)

EducationItem.create(
  resume_id: resume_75.id,
  name: 'Project Management',
  institute: 'University of Mississippi',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_75.id,
  name: 'PMP Certification',
  institute: 'Project Management Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_75,
  name: 'Project Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_75,
  name: 'Team Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_75,
  name: 'Delivery Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_75,
  name: 'Stakeholder Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_75,
  name: 'Risk Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_75,
  position: 'Senior Project Coordinator',
  company: 'Project Excellence Corp',
  location: 'Jackson, MS',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated complex projects with budgets exceeding $2M, ensuring successful delivery within scope, budget, and timeline constraints while maintaining high quality standards. Managed cross-functional project teams and coordinated resources to ensure project milestones were met and objectives achieved. Developed and maintained project schedules, coordinated stakeholder communications, and managed project risks to ensure successful outcomes.'
)

WorkExperienceItem.create(
  resume: resume_75,
  position: 'Project Coordinator',
  company: 'Project Solutions Pro',
  location: 'Jackson, MS',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Coordinated project activities and supported project managers in delivering successful project outcomes. Managed project schedules and coordinated team resources. Assisted with stakeholder communications and project documentation.'
)

ExternalLinkItem.create(
  resume: resume_75,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate75'
)

ReferenceItem.create(
  resume: resume_75,
  name: 'Sarah Johnson',
  position: 'Project Director',
  company: 'Project Excellence Corp',
  mobile: '+1 555 0075',
  kind: :job
)

ReferenceItem.create(
  resume: resume_75,
  name: 'Robert Wilson',
  position: 'Senior PM',
  company: 'Project Solutions Pro',
  mobile: '+1 555 0075',
  kind: :personal
)

# Candidate 76
candidate_76 = Candidate.new(email: 'candidate_76@simplestresumes.com', password: password)
candidate_76.skip_confirmation!
candidate_76.save

resume_76 = Resume.create(
  candidate_id: candidate_76.id,
  name: 'Nicole Davis',
  email: candidate_76.email,
  mobile: '+1 555 0076',
  location: 'Kansas City, MO',
  about_me: 'Innovative UX designer with expertise in user research and interface design. I create intuitive user experiences that delight users and drive engagement.'
)

EducationItem.create(
  resume_id: resume_76.id,
  name: 'User Experience Design',
  institute: 'University of Missouri',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_76.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_76,
  name: 'UX Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_76,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_76,
  name: 'Interface Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_76,
  name: 'Wireframing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_76,
  name: 'Prototyping',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_76,
  position: 'Senior UX Designer',
  company: 'UX Design Studio',
  location: 'Kansas City, MO',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led UX design initiatives for digital products serving millions of users, resulting in 50% improvement in user satisfaction scores and 35% reduction in user support requests. Conducted comprehensive user research including interviews, surveys, and usability testing to inform design decisions and validate solutions. Developed user personas, journey maps, and design systems that ensured consistent and intuitive user experiences across all product touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_76,
  position: 'UX Designer',
  company: 'Digital Experience Lab',
  location: 'Kansas City, MO',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Designed user interfaces and user experiences for web and mobile applications. Conducted user research and usability testing to inform design decisions. Created wireframes, prototypes, and design specifications for development teams.'
)

ExternalLinkItem.create(
  resume: resume_76,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate76'
)

ExternalLinkItem.create(
  resume: resume_76,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate76'
)

ReferenceItem.create(
  resume: resume_76,
  name: 'David Kim',
  position: 'UX Director',
  company: 'UX Design Studio',
  mobile: '+1 555 0076',
  kind: :job
)

ReferenceItem.create(
  resume: resume_76,
  name: 'Lisa Rodriguez',
  position: 'Design Manager',
  company: 'Digital Experience Lab',
  mobile: '+1 555 0076',
  kind: :personal
)

# Candidate 77
candidate_77 = Candidate.new(email: 'candidate_77@simplestresumes.com', password: password)
candidate_77.skip_confirmation!
candidate_77.save

resume_77 = Resume.create(
  candidate_id: candidate_77.id,
  name: 'James Johnson',
  email: candidate_77.email,
  mobile: '+1 555 0077',
  location: 'Helena, MT',
  about_me: 'Strategic business consultant with expertise in process improvement and organizational development. I help organizations optimize performance and achieve growth objectives.'
)

EducationItem.create(
  resume_id: resume_77.id,
  name: 'Business Administration',
  institute: 'University of Montana',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_77.id,
  name: 'Management Consulting Certification',
  institute: 'McKinsey',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_77,
  name: 'Business Consulting',
  kind: :primary
)

SkillItem.create(
  resume: resume_77,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_77,
  name: 'Organizational Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_77,
  name: 'Change Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_77,
  name: 'Performance Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_77,
  position: 'Senior Business Consultant',
  company: 'Strategic Consulting Group',
  location: 'Helena, MT',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led strategic consulting engagements for Fortune 500 companies, delivering solutions that improved operational efficiency by 45% and increased profitability by 30%. Developed comprehensive business strategies and organizational development plans that supported long-term growth objectives. Managed client relationships and project teams, ensuring successful delivery of consulting services and measurable business outcomes.'
)

WorkExperienceItem.create(
  resume: resume_77,
  position: 'Business Consultant',
  company: 'Management Solutions Pro',
  location: 'Helena, MT',
  start_month: 6,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Provided business consulting services to various client organizations, analyzing business processes and developing improvement recommendations. Conducted organizational assessments and supported strategic planning initiatives. Worked with client teams to implement recommended changes and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_77,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate77'
)

ReferenceItem.create(
  resume: resume_77,
  name: 'Sarah Davis',
  position: 'Consulting Director',
  company: 'Strategic Consulting Group',
  mobile: '+1 555 0077',
  kind: :job
)

ReferenceItem.create(
  resume: resume_77,
  name: 'David Brown',
  position: 'Senior Consultant',
  company: 'Management Solutions Pro',
  mobile: '+1 555 0077',
  kind: :personal
)

# Candidate 78
candidate_78 = Candidate.new(email: 'candidate_78@simplestresumes.com', password: password)
candidate_78.skip_confirmation!
candidate_78.save

resume_78 = Resume.create(
  candidate_id: candidate_78.id,
  name: 'Stephanie Wilson',
  email: candidate_78.email,
  mobile: '+1 555 0078',
  location: 'Omaha, NE',
  about_me: 'Creative content strategist with expertise in storytelling and audience engagement. I develop content that connects with people and drives meaningful results.'
)

EducationItem.create(
  resume_id: resume_78.id,
  name: 'Communications',
  institute: 'University of Nebraska',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_78.id,
  name: 'Content Strategy Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_78,
  name: 'Content Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_78,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_78,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_78,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_78,
  name: 'SEO',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_78,
  position: 'Senior Content Strategist',
  company: 'Content Strategy Pro',
  location: 'Omaha, NE',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content strategy initiatives for major brands and organizations, developing comprehensive content plans that increased audience engagement by 55% and improved brand recognition across multiple platforms. Created content strategies that aligned with business objectives and target audience preferences, ensuring consistent messaging and brand voice. Collaborated with creative teams to develop engaging content that effectively communicated brand messages and drove desired customer actions.'
)

WorkExperienceItem.create(
  resume: resume_78,
  position: 'Content Strategist',
  company: 'Creative Content Agency',
  location: 'Omaha, NE',
  start_month: 1,
  start_year: 2021,
  end_month: 6,
  end_year: 2022,
  description: 'Developed content strategies for client campaigns and managed content creation processes. Created engaging content for various platforms and conducted content performance analysis to optimize strategies. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_78,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate78'
)

ExternalLinkItem.create(
  resume: resume_78,
  name: 'Content Portfolio',
  url: 'https://candidate78-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_78,
  name: 'Robert Johnson',
  position: 'Content Director',
  company: 'Content Strategy Pro',
  mobile: '+1 555 0078',
  kind: :job
)

ReferenceItem.create(
  resume: resume_78,
  name: 'Michael Chen',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0078',
  kind: :personal
)

# Candidate 79
candidate_79 = Candidate.new(email: 'candidate_79@simplestresumes.com', password: password)
candidate_79.skip_confirmation!
candidate_79.save

resume_79 = Resume.create(
  candidate_id: candidate_79.id,
  name: 'Kevin Anderson',
  email: candidate_79.email,
  mobile: '+1 555 0079',
  location: 'Las Vegas, NV',
  about_me: 'Experienced data scientist with expertise in machine learning and predictive analytics. I develop models that provide insights and drive data-driven decision making.'
)

EducationItem.create(
  resume_id: resume_79.id,
  name: 'Data Science',
  institute: 'University of Nevada',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_79.id,
  name: 'Machine Learning Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_79,
  name: 'Data Science',
  kind: :primary
)

SkillItem.create(
  resume: resume_79,
  name: 'Machine Learning',
  kind: :primary
)

SkillItem.create(
  resume: resume_79,
  name: 'Predictive Analytics',
  kind: :primary
)

SkillItem.create(
  resume: resume_79,
  name: 'Python',
  kind: :secondary
)

SkillItem.create(
  resume: resume_79,
  name: 'R',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_79,
  position: 'Senior Data Scientist',
  company: 'Data Science Lab',
  location: 'Las Vegas, NV',
  start_month: 2,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data science initiatives that delivered actionable insights and predictive models for business decision-making, resulting in 25% improvement in operational efficiency and 20% increase in revenue. Developed machine learning models for customer segmentation, churn prediction, and demand forecasting that supported strategic business planning. Collaborated with business stakeholders to understand data needs and translate complex analytical findings into clear, actionable recommendations.'
)

WorkExperienceItem.create(
  resume: resume_79,
  position: 'Data Scientist',
  company: 'Analytics Solutions Inc',
  location: 'Las Vegas, NV',
  start_month: 8,
  start_year: 2020,
  end_month: 1,
  end_year: 2022,
  description: 'Developed machine learning models and conducted data analysis to support business decision-making processes. Created predictive models and conducted statistical analysis to identify trends and opportunities. Worked with business teams to implement data-driven solutions and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_79,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate79'
)

ExternalLinkItem.create(
  resume: resume_79,
  name: 'GitHub',
  url: 'https://github.com/candidate79'
)

ReferenceItem.create(
  resume: resume_79,
  name: 'Rachel Green',
  position: 'Data Science Director',
  company: 'Data Science Lab',
  mobile: '+1 555 0079',
  kind: :job
)

ReferenceItem.create(
  resume: resume_79,
  name: 'Kevin Martinez',
  position: 'Senior Scientist',
  company: 'Analytics Solutions Inc',
  mobile: '+1 555 0079',
  kind: :personal
)

# Candidate 80
candidate_80 = Candidate.new(email: 'candidate_80@simplestresumes.com', password: password)
candidate_80.skip_confirmation!
candidate_80.save

resume_80 = Resume.create(
  candidate_id: candidate_80.id,
  name: 'Michelle Davis',
  email: candidate_80.email,
  mobile: '+1 555 0080',
  location: 'Manchester, NH',
  about_me: 'Strategic marketing manager with expertise in campaign development and brand growth. I develop marketing strategies that increase market share and customer engagement.'
)

EducationItem.create(
  resume_id: resume_80.id,
  name: 'Marketing',
  institute: 'University of New Hampshire',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_80.id,
  name: 'Digital Marketing Certification',
  institute: 'HubSpot Academy',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_80,
  name: 'Marketing Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_80,
  name: 'Campaign Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_80,
  name: 'Brand Growth',
  kind: :primary
)

SkillItem.create(
  resume: resume_80,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_80,
  name: 'Customer Engagement',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_80,
  position: 'Senior Marketing Manager',
  company: 'Strategic Marketing Group',
  location: 'Manchester, NH',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive marketing strategies for major brands, developing campaigns that increased market share by 35% and improved customer engagement by 50% across multiple channels. Managed integrated marketing campaigns from concept to execution, ensuring consistent messaging and optimal performance across all touchpoints. Conducted market research and competitive analysis to inform marketing decisions and identify opportunities for growth and market expansion.'
)

WorkExperienceItem.create(
  resume: resume_80,
  position: 'Marketing Manager',
  company: 'Marketing Solutions Pro',
  location: 'Manchester, NH',
  start_month: 3,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Developed marketing strategies for client campaigns and managed marketing initiatives across various channels. Conducted market research and competitive analysis to inform marketing decisions. Collaborated with creative teams to develop marketing materials and ensure brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_80,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate80'
)

ExternalLinkItem.create(
  resume: resume_80,
  name: 'Marketing Blog',
  url: 'https://candidate80-marketing-blog.com'
)

ReferenceItem.create(
  resume: resume_80,
  name: 'Christopher Lee',
  position: 'Marketing Director',
  company: 'Strategic Marketing Group',
  mobile: '+1 555 0080',
  kind: :job
)

ReferenceItem.create(
  resume: resume_80,
  name: 'Jennifer Davis',
  position: 'Brand Manager',
  company: 'Marketing Solutions Pro',
  mobile: '+1 555 0080',
  kind: :personal
)

# Candidate 81
candidate_81 = Candidate.new(email: 'candidate_81@simplestresumes.com', password: password)
candidate_81.skip_confirmation!
candidate_81.save

resume_81 = Resume.create(
  candidate_id: candidate_81.id,
  name: 'Robert Taylor',
  email: candidate_81.email,
  mobile: '+1 555 0081',
  location: 'Newark, NJ',
  about_me: 'Strategic product manager with expertise in agile development and user experience optimization. I deliver products that exceed user expectations and drive business growth.'
)

EducationItem.create(
  resume_id: resume_81.id,
  name: 'Product Management',
  institute: 'Rutgers University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_81.id,
  name: 'Agile Scrum Master',
  institute: 'Scrum Alliance',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_81,
  name: 'Product Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_81,
  name: 'Agile Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_81,
  name: 'User Experience',
  kind: :primary
)

SkillItem.create(
  resume: resume_81,
  name: 'Product Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_81,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_81,
  position: 'Senior Product Manager',
  company: 'Product Innovation Corp',
  location: 'Newark, NJ',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy and development for a portfolio of digital products serving over 180,000 users, resulting in 45% increase in user engagement and 30% improvement in customer satisfaction scores. Managed cross-functional product teams using agile methodologies, ensuring timely delivery of high-quality products that met user needs and business objectives. Conducted comprehensive user research and market analysis to inform product decisions and prioritize feature development.'
)

WorkExperienceItem.create(
  resume: resume_81,
  position: 'Product Manager',
  company: 'Digital Products Solutions',
  location: 'Newark, NJ',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Managed product development lifecycle for multiple digital products, working with development teams to deliver features and improvements. Conducted user research and gathered feedback to inform product decisions and prioritize development efforts. Collaborated with stakeholders to define product requirements and ensure successful product launches.'
)

ExternalLinkItem.create(
  resume: resume_81,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate81'
)

ExternalLinkItem.create(
  resume: resume_81,
  name: 'Product Blog',
  url: 'https://candidate81-product-blog.com'
)

ReferenceItem.create(
  resume: resume_81,
  name: 'Jessica Wilson',
  position: 'VP of Product',
  company: 'Product Innovation Corp',
  mobile: '+1 555 0081',
  kind: :job
)

ReferenceItem.create(
  resume: resume_81,
  name: 'Mark Johnson',
  position: 'Product Director',
  company: 'Digital Products Solutions',
  mobile: '+1 555 0081',
  kind: :personal
)

# Candidate 82
candidate_82 = Candidate.new(email: 'candidate_82@simplestresumes.com', password: password)
candidate_82.skip_confirmation!
candidate_82.save

resume_82 = Resume.create(
  candidate_id: candidate_82.id,
  name: 'Lisa Anderson',
  email: candidate_82.email,
  mobile: '+1 555 0082',
  location: 'Albuquerque, NM',
  about_me: 'Creative graphic designer with expertise in visual communication and brand identity development. I create compelling designs that effectively communicate messages and enhance brand recognition.'
)

EducationItem.create(
  resume_id: resume_82.id,
  name: 'Graphic Design',
  institute: 'University of New Mexico',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_82.id,
  name: 'Adobe Creative Suite Certification',
  institute: 'Adobe',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_82,
  name: 'Graphic Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_82,
  name: 'Visual Communication',
  kind: :primary
)

SkillItem.create(
  resume: resume_82,
  name: 'Brand Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_82,
  name: 'Typography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_82,
  name: 'Layout Design',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_82,
  position: 'Senior Graphic Designer',
  company: 'Creative Design Studio',
  location: 'Albuquerque, NM',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led creative design projects for major brands and organizations, developing visual identities and marketing materials that increased brand recognition by 50% and improved customer engagement. Managed design teams and creative processes, ensuring high-quality deliverables that met client objectives and brand guidelines. Collaborated with marketing teams to develop cohesive visual strategies that supported business goals and enhanced brand presence.'
)

WorkExperienceItem.create(
  resume: resume_82,
  position: 'Graphic Designer',
  company: 'Visual Design Agency',
  location: 'Albuquerque, NM',
  start_month: 1,
  start_year: 2021,
  end_month: 6,
  end_year: 2022,
  description: 'Created graphic designs for various client projects including logos, marketing materials, and digital assets. Worked with creative teams to develop visual concepts and ensure brand consistency. Managed multiple design projects and met client deadlines.'
)

ExternalLinkItem.create(
  resume: resume_82,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate82'
)

ExternalLinkItem.create(
  resume: resume_82,
  name: 'Behance',
  url: 'https://behance.net/candidate82'
)

ReferenceItem.create(
  resume: resume_82,
  name: 'Michael Rodriguez',
  position: 'Creative Director',
  company: 'Creative Design Studio',
  mobile: '+1 555 0082',
  kind: :job
)

ReferenceItem.create(
  resume: resume_82,
  name: 'Sarah Kim',
  position: 'Design Manager',
  company: 'Visual Design Agency',
  mobile: '+1 555 0082',
  kind: :personal
)

# Candidate 83
candidate_83 = Candidate.new(email: 'candidate_83@simplestresumes.com', password: password)
candidate_83.skip_confirmation!
candidate_83.save

resume_83 = Resume.create(
  candidate_id: candidate_83.id,
  name: 'David Wilson',
  email: candidate_83.email,
  mobile: '+1 555 0083',
  location: 'Las Vegas, NV',
  about_me: 'Experienced business analyst with expertise in process optimization and data-driven decision making. I help organizations improve efficiency and achieve operational excellence.'
)

EducationItem.create(
  resume_id: resume_83.id,
  name: 'Business Analysis',
  institute: 'University of Nevada',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_83.id,
  name: 'Six Sigma Green Belt',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_83,
  name: 'Business Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_83,
  name: 'Process Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_83,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_83,
  name: 'Requirements Gathering',
  kind: :secondary
)

SkillItem.create(
  resume: resume_83,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_83,
  position: 'Senior Business Analyst',
  company: 'Business Optimization Group',
  location: 'Las Vegas, NV',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business analysis initiatives that identified and implemented process improvements resulting in 40% reduction in operational costs and 50% improvement in process efficiency. Conducted comprehensive business process analysis and developed recommendations for optimization that supported organizational goals and improved customer experience. Managed stakeholder relationships and facilitated workshops to gather requirements and ensure alignment on business objectives.'
)

WorkExperienceItem.create(
  resume: resume_83,
  position: 'Business Analyst',
  company: 'Process Solutions Inc',
  location: 'Las Vegas, NV',
  start_month: 8,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Analyzed business processes and gathered requirements for system improvements and process optimization projects. Created business process documentation and worked with stakeholders to ensure accurate requirement definition. Supported project teams in implementing process improvements and system enhancements.'
)

ExternalLinkItem.create(
  resume: resume_83,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate83'
)

ReferenceItem.create(
  resume: resume_83,
  name: 'Amanda Rodriguez',
  position: 'Business Analysis Director',
  company: 'Business Optimization Group',
  mobile: '+1 555 0083',
  kind: :job
)

ReferenceItem.create(
  resume: resume_83,
  name: 'Carlos Mendez',
  position: 'Process Manager',
  company: 'Process Solutions Inc',
  mobile: '+1 555 0083',
  kind: :personal
)

# Candidate 84
candidate_84 = Candidate.new(email: 'candidate_84@simplestresumes.com', password: password)
candidate_84.skip_confirmation!
candidate_84.save

resume_84 = Resume.create(
  candidate_id: candidate_84.id,
  name: 'Jennifer Davis',
  email: candidate_84.email,
  mobile: '+1 555 0084',
  location: 'Reno, NV',
  about_me: 'Creative marketing coordinator with expertise in campaign execution and brand management. I coordinate marketing efforts that drive results and enhance brand presence.'
)

EducationItem.create(
  resume_id: resume_84.id,
  name: 'Marketing',
  institute: 'University of Nevada',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_84.id,
  name: 'Digital Marketing Certification',
  institute: 'Google Digital Garage',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_84,
  name: 'Campaign Execution',
  kind: :primary
)

SkillItem.create(
  resume: resume_84,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_84,
  name: 'Marketing Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_84,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_84,
  name: 'Social Media',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_84,
  position: 'Senior Marketing Coordinator',
  company: 'Marketing Excellence Corp',
  location: 'Reno, NV',
  start_month: 11,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated comprehensive marketing campaigns for major brands, managing multiple channels and ensuring consistent messaging that increased brand awareness by 45% and improved customer engagement. Developed and executed marketing strategies that aligned with business objectives and target audience preferences. Coordinated with creative teams, media partners, and stakeholders to ensure successful campaign delivery and measurable results.'
)

WorkExperienceItem.create(
  resume: resume_84,
  position: 'Marketing Coordinator',
  company: 'Creative Marketing Solutions',
  location: 'Reno, NV',
  start_month: 5,
  start_year: 2021,
  end_month: 10,
  end_year: 2022,
  description: 'Coordinated marketing campaigns and supported brand management initiatives for various client accounts. Assisted with content creation and social media management. Coordinated with creative teams and ensured campaign deliverables met quality standards.'
)

ExternalLinkItem.create(
  resume: resume_84,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate84'
)

ExternalLinkItem.create(
  resume: resume_84,
  name: 'Marketing Portfolio',
  url: 'https://candidate84-marketing-portfolio.com'
)

ReferenceItem.create(
  resume: resume_84,
  name: 'Michael Chen',
  position: 'Marketing Director',
  company: 'Marketing Excellence Corp',
  mobile: '+1 555 0084',
  kind: :job
)

ReferenceItem.create(
  resume: resume_84,
  name: 'Lisa Rodriguez',
  position: 'Brand Manager',
  company: 'Creative Marketing Solutions',
  mobile: '+1 555 0084',
  kind: :personal
)

# Candidate 85
candidate_85 = Candidate.new(email: 'candidate_85@simplestresumes.com', password: password)
candidate_85.skip_confirmation!
candidate_85.save

resume_85 = Resume.create(
  candidate_id: candidate_85.id,
  name: 'Christopher Brown',
  email: candidate_85.email,
  mobile: '+1 555 0085',
  location: 'Henderson, NV',
  about_me: 'Experienced project coordinator with expertise in team coordination and project delivery. I ensure projects are completed on time and within budget through effective coordination.'
)

EducationItem.create(
  resume_id: resume_85.id,
  name: 'Project Management',
  institute: 'University of Nevada',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_85.id,
  name: 'Agile Certification',
  institute: 'Scrum Alliance',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_85,
  name: 'Project Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_85,
  name: 'Team Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_85,
  name: 'Project Delivery',
  kind: :primary
)

SkillItem.create(
  resume: resume_85,
  name: 'Schedule Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_85,
  name: 'Resource Allocation',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_85,
  position: 'Senior Project Coordinator',
  company: 'Project Excellence Group',
  location: 'Henderson, NV',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated complex projects with budgets exceeding $1.8M, ensuring successful delivery within scope, budget, and timeline constraints while maintaining high quality standards. Managed cross-functional project teams and coordinated resources to ensure project milestones were met and objectives achieved. Developed and maintained project schedules, coordinated stakeholder communications, and managed project risks to ensure successful outcomes.'
)

WorkExperienceItem.create(
  resume: resume_85,
  position: 'Project Coordinator',
  company: 'Project Solutions Pro',
  location: 'Henderson, NV',
  start_month: 2,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Coordinated project activities and supported project managers in delivering successful project outcomes. Managed project schedules and coordinated team resources. Assisted with stakeholder communications and project documentation.'
)

ExternalLinkItem.create(
  resume: resume_85,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate85'
)

ReferenceItem.create(
  resume: resume_85,
  name: 'Sarah Johnson',
  position: 'Project Director',
  company: 'Project Excellence Group',
  mobile: '+1 555 0085',
  kind: :job
)

ReferenceItem.create(
  resume: resume_85,
  name: 'Robert Wilson',
  position: 'Senior PM',
  company: 'Project Solutions Pro',
  mobile: '+1 555 0085',
  kind: :personal
)

# Candidate 86
candidate_86 = Candidate.new(email: 'candidate_86@simplestresumes.com', password: password)
candidate_86.skip_confirmation!
candidate_86.save

resume_86 = Resume.create(
  candidate_id: candidate_86.id,
  name: 'Nicole Wilson',
  email: candidate_86.email,
  mobile: '+1 555 0086',
  location: 'Carson City, NV',
  about_me: 'Innovative web developer with expertise in front-end development and user experience. I create responsive websites that provide excellent user experiences and drive engagement.'
)

EducationItem.create(
  resume_id: resume_86.id,
  name: 'Web Development',
  institute: 'University of Nevada',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_86.id,
  name: 'React Certification',
  institute: 'Meta',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_86,
  name: 'Front-end Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_86,
  name: 'Web Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_86,
  name: 'User Experience',
  kind: :primary
)

SkillItem.create(
  resume: resume_86,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_86,
  name: 'CSS',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_86,
  position: 'Senior Web Developer',
  company: 'Web Development Studio',
  location: 'Carson City, NV',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led web development projects for major clients, creating responsive websites and web applications that improved user engagement by 55% and enhanced online presence. Developed front-end solutions using modern technologies and best practices that ensured optimal performance and user experience. Collaborated with design and back-end teams to deliver cohesive web solutions that met client requirements and exceeded expectations.'
)

WorkExperienceItem.create(
  resume: resume_86,
  position: 'Web Developer',
  company: 'Digital Web Solutions',
  location: 'Carson City, NV',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Developed websites and web applications for various client projects. Created responsive designs and ensured cross-browser compatibility. Worked with design teams to implement visual designs and maintain code quality.'
)

ExternalLinkItem.create(
  resume: resume_86,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate86'
)

ExternalLinkItem.create(
  resume: resume_86,
  name: 'GitHub',
  url: 'https://github.com/candidate86'
)

ReferenceItem.create(
  resume: resume_86,
  name: 'Christopher Lee',
  position: 'Development Director',
  company: 'Web Development Studio',
  mobile: '+1 555 0086',
  kind: :job
)

ReferenceItem.create(
  resume: resume_86,
  name: 'David Kim',
  position: 'Senior Developer',
  company: 'Digital Web Solutions',
  mobile: '+1 555 0086',
  kind: :personal
)

# Candidate 87
candidate_87 = Candidate.new(email: 'candidate_87@simplestresumes.com', password: password)
candidate_87.skip_confirmation!
candidate_87.save

resume_87 = Resume.create(
  candidate_id: candidate_87.id,
  name: 'Michael Rodriguez',
  email: candidate_87.email,
  mobile: '+1 555 0087',
  location: 'Albany, NY',
  about_me: 'Strategic operations analyst with expertise in performance optimization and process improvement. I analyze operations to identify opportunities for enhancement and efficiency gains.'
)

EducationItem.create(
  resume_id: resume_87.id,
  name: 'Operations Management',
  institute: 'University at Albany',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_87.id,
  name: 'Lean Six Sigma Certification',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_87,
  name: 'Operations Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_87,
  name: 'Performance Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_87,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_87,
  name: 'Data Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_87,
  name: 'Performance Metrics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_87,
  position: 'Senior Operations Analyst',
  company: 'Operations Excellence Corp',
  location: 'Albany, NY',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led operations analysis initiatives that identified and implemented performance improvements resulting in 35% increase in operational efficiency and 30% reduction in costs while maintaining quality standards. Conducted comprehensive performance analysis and developed optimization strategies that supported organizational goals and improved customer satisfaction. Managed performance metrics and reporting systems that provided insights for continuous improvement and strategic decision-making.'
)

WorkExperienceItem.create(
  resume: resume_87,
  position: 'Operations Analyst',
  company: 'Performance Solutions Inc',
  location: 'Albany, NY',
  start_month: 7,
  start_year: 2021,
  end_month: 11,
  end_year: 2021,
  description: 'Analyzed operational performance and identified opportunities for improvement and optimization. Developed performance metrics and reporting systems to support operational decision-making. Supported process improvement initiatives and performance optimization projects.'
)

ExternalLinkItem.create(
  resume: resume_87,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate87'
)

ReferenceItem.create(
  resume: resume_87,
  name: 'Jennifer Wilson',
  position: 'Operations Director',
  company: 'Operations Excellence Corp',
  mobile: '+1 555 0087',
  kind: :job
)

ReferenceItem.create(
  resume: resume_87,
  name: 'Robert Brown',
  position: 'Performance Manager',
  company: 'Performance Solutions Inc',
  mobile: '+1 555 0087',
  kind: :personal
)

# Candidate 88
candidate_88 = Candidate.new(email: 'candidate_88@simplestresumes.com', password: password)
candidate_88.skip_confirmation!
candidate_88.save

resume_88 = Resume.create(
  candidate_id: candidate_88.id,
  name: 'Sarah Johnson',
  email: candidate_88.email,
  mobile: '+1 555 0088',
  location: 'Buffalo, NY',
  about_me: 'Creative content creator with expertise in storytelling and audience engagement. I develop compelling content that connects with audiences and drives meaningful engagement.'
)

EducationItem.create(
  resume_id: resume_88.id,
  name: 'Communications',
  institute: 'University at Buffalo',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_88.id,
  name: 'Content Creation Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_88,
  name: 'Content Creation',
  kind: :primary
)

SkillItem.create(
  resume: resume_88,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_88,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_88,
  name: 'Content Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_88,
  name: 'Creative Writing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_88,
  position: 'Senior Content Creator',
  company: 'Content Creation Studio',
  location: 'Buffalo, NY',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content creation initiatives for major brands and organizations, developing compelling content that increased audience engagement by 60% and improved brand recognition across multiple platforms. Created diverse content types including articles, videos, and social media posts that effectively communicated brand messages and engaged target audiences. Collaborated with marketing teams to develop content strategies that aligned with business objectives and audience preferences.'
)

WorkExperienceItem.create(
  resume: resume_88,
  position: 'Content Creator',
  company: 'Creative Content Agency',
  location: 'Buffalo, NY',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Created engaging content for various client campaigns and platforms. Developed content strategies and created diverse content types to support marketing objectives. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_88,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate88'
)

ExternalLinkItem.create(
  resume: resume_88,
  name: 'Content Portfolio',
  url: 'https://candidate88-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_88,
  name: 'David Chen',
  position: 'Content Director',
  company: 'Content Creation Studio',
  mobile: '+1 555 0088',
  kind: :job
)

ReferenceItem.create(
  resume: resume_88,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0088',
  kind: :personal
)

# Candidate 89
candidate_89 = Candidate.new(email: 'candidate_89@simplestresumes.com', password: password)
candidate_89.skip_confirmation!
candidate_89.save

resume_89 = Resume.create(
  candidate_id: candidate_89.id,
  name: 'Christopher Lee',
  email: candidate_89.email,
  mobile: '+1 555 0089',
  location: 'Rochester, NY',
  about_me: 'Experienced data analyst with expertise in statistical analysis and business intelligence. I transform data into actionable insights that support strategic decision-making.'
)

EducationItem.create(
  resume_id: resume_89.id,
  name: 'Data Science',
  institute: 'University of Rochester',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_89.id,
  name: 'Statistical Analysis Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_89,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_89,
  name: 'Statistical Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_89,
  name: 'Business Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_89,
  name: 'Data Visualization',
  kind: :secondary
)

SkillItem.create(
  resume: resume_89,
  name: 'SQL',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_89,
  position: 'Senior Data Analyst',
  company: 'Data Analytics Group',
  location: 'Rochester, NY',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data analysis initiatives that provided critical insights for strategic decision-making, supporting business growth initiatives that increased revenue by 35% and improved operational efficiency by 30%. Conducted comprehensive statistical analysis and developed predictive models that identified trends and opportunities for business optimization. Created data visualizations and reports that effectively communicated complex analytical findings to stakeholders and supported data-driven decision-making.'
)

WorkExperienceItem.create(
  resume: resume_89,
  position: 'Data Analyst',
  company: 'Analytics Solutions Pro',
  location: 'Rochester, NY',
  start_month: 12,
  start_year: 2020,
  end_month: 6,
  end_year: 2022,
  description: 'Analyzed business data and conducted statistical analysis to support decision-making processes. Created data visualizations and reports that communicated insights to stakeholders. Supported business intelligence initiatives and data-driven decision-making.'
)

ExternalLinkItem.create(
  resume: resume_89,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate89'
)

ExternalLinkItem.create(
  resume: resume_89,
  name: 'GitHub',
  url: 'https://github.com/candidate89'
)

ReferenceItem.create(
  resume: resume_89,
  name: 'Amanda Rodriguez',
  position: 'Analytics Director',
  company: 'Data Analytics Group',
  mobile: '+1 555 0089',
  kind: :job
)

ReferenceItem.create(
  resume: resume_89,
  name: 'Michael Chen',
  position: 'Senior Analyst',
  company: 'Analytics Solutions Pro',
  mobile: '+1 555 0089',
  kind: :personal
)

# Candidate 90
candidate_90 = Candidate.new(email: 'candidate_90@simplestresumes.com', password: password)
candidate_90.skip_confirmation!
candidate_90.save

resume_90 = Resume.create(
  candidate_id: candidate_90.id,
  name: 'Nicole Wilson',
  email: candidate_90.email,
  mobile: '+1 555 0090',
  location: 'Yonkers, NY',
  about_me: 'Innovative product manager with expertise in agile methodologies and user-centered design. I deliver products that solve real problems and create meaningful user experiences.'
)

EducationItem.create(
  resume_id: resume_90.id,
  name: 'Product Management',
  institute: 'Fordham University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_90.id,
  name: 'Agile Scrum Master',
  institute: 'Scrum Alliance',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_90,
  name: 'Product Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_90,
  name: 'Agile Methodologies',
  kind: :primary
)

SkillItem.create(
  resume: resume_90,
  name: 'User-Centered Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_90,
  name: 'Product Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_90,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_90,
  position: 'Senior Product Manager',
  company: 'Product Innovation Corp',
  location: 'Yonkers, NY',
  start_month: 2,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy and development for a portfolio of digital products serving over 160,000 users, resulting in 40% increase in user engagement and 35% improvement in customer satisfaction scores. Managed cross-functional product teams using agile methodologies, ensuring timely delivery of high-quality products that met user needs and business objectives. Conducted user research and market analysis to inform product decisions and prioritize feature development.'
)

WorkExperienceItem.create(
  resume: resume_90,
  position: 'Product Manager',
  company: 'Digital Products Solutions',
  location: 'Yonkers, NY',
  start_month: 7,
  start_year: 2020,
  end_month: 1,
  end_year: 2022,
  description: 'Managed product development lifecycle for multiple digital products, working with development teams to deliver features and improvements. Conducted user research and gathered feedback to inform product decisions and prioritize development efforts. Collaborated with stakeholders to define product requirements and ensure successful product launches.'
)

ExternalLinkItem.create(
  resume: resume_90,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate90'
)

ExternalLinkItem.create(
  resume: resume_90,
  name: 'Product Blog',
  url: 'https://candidate90-product-blog.com'
)

ReferenceItem.create(
  resume: resume_90,
  name: 'Jessica Taylor',
  position: 'VP of Product',
  company: 'Product Innovation Corp',
  mobile: '+1 555 0090',
  kind: :job
)

ReferenceItem.create(
  resume: resume_90,
  name: 'Mark Johnson',
  position: 'Product Director',
  company: 'Digital Products Solutions',
  mobile: '+1 555 0090',
  kind: :personal
)

# Candidate 91
candidate_91 = Candidate.new(email: 'candidate_91@simplestresumes.com', password: password)
candidate_91.skip_confirmation!
candidate_91.save

resume_91 = Resume.create(
  candidate_id: candidate_91.id,
  name: 'Andrew Davis',
  email: candidate_91.email,
  mobile: '+1 555 0091',
  location: 'Charlotte, NC',
  about_me: 'Strategic business development professional with expertise in market expansion and partnership development. I identify opportunities and build strategic relationships.'
)

EducationItem.create(
  resume_id: resume_91.id,
  name: 'Business Development',
  institute: 'University of North Carolina',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_91.id,
  name: 'Strategic Partnerships Certification',
  institute: 'Business Development Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_91,
  name: 'Business Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_91,
  name: 'Market Expansion',
  kind: :primary
)

SkillItem.create(
  resume: resume_91,
  name: 'Partnership Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_91,
  name: 'Strategic Planning',
  kind: :secondary
)

SkillItem.create(
  resume: resume_91,
  name: 'Relationship Building',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_91,
  position: 'Senior Business Development Manager',
  company: 'Business Growth Partners',
  location: 'Charlotte, NC',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business development initiatives that expanded market presence into 7 new territories and established strategic partnerships that generated $18M in additional revenue. Developed and executed market expansion strategies that identified new opportunities and positioned the company for sustainable growth in emerging markets. Built and maintained relationships with key partners, clients, and stakeholders that supported business objectives and created new revenue streams.'
)

WorkExperienceItem.create(
  resume: resume_91,
  position: 'Business Development Manager',
  company: 'Strategic Partnerships Inc',
  location: 'Charlotte, NC',
  start_month: 3,
  start_year: 2021,
  end_month: 7,
  end_year: 2022,
  description: 'Identified new business opportunities and developed strategies for market expansion and growth. Built relationships with potential partners and clients to support business development objectives. Conducted market research and analysis to inform business development strategies.'
)

ExternalLinkItem.create(
  resume: resume_91,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate91'
)

ReferenceItem.create(
  resume: resume_91,
  name: 'David Thompson',
  position: 'Business Development Director',
  company: 'Business Growth Partners',
  mobile: '+1 555 0091',
  kind: :job
)

ReferenceItem.create(
  resume: resume_91,
  name: 'Lisa Anderson',
  position: 'Partnership Manager',
  company: 'Strategic Partnerships Inc',
  mobile: '+1 555 0091',
  kind: :personal
)

# Candidate 92
candidate_92 = Candidate.new(email: 'candidate_92@simplestresumes.com', password: password)
candidate_92.skip_confirmation!
candidate_92.save

resume_92 = Resume.create(
  candidate_id: candidate_92.id,
  name: 'Stephanie Johnson',
  email: candidate_92.email,
  mobile: '+1 555 0092',
  location: 'Raleigh, NC',
  about_me: 'Creative UX designer with expertise in user research and interface design. I create intuitive user experiences that delight users and drive engagement.'
)

EducationItem.create(
  resume_id: resume_92.id,
  name: 'User Experience Design',
  institute: 'North Carolina State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_92.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_92,
  name: 'UX Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_92,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_92,
  name: 'Interface Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_92,
  name: 'Wireframing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_92,
  name: 'Prototyping',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_92,
  position: 'Senior UX Designer',
  company: 'UX Design Studio',
  location: 'Raleigh, NC',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led UX design initiatives for digital products serving millions of users, resulting in 55% improvement in user satisfaction scores and 40% reduction in user support requests. Conducted comprehensive user research including interviews, surveys, and usability testing to inform design decisions and validate solutions. Developed user personas, journey maps, and design systems that ensured consistent and intuitive user experiences across all product touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_92,
  position: 'UX Designer',
  company: 'Digital Experience Lab',
  location: 'Raleigh, NC',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Designed user interfaces and user experiences for web and mobile applications. Conducted user research and usability testing to inform design decisions. Created wireframes, prototypes, and design specifications for development teams.'
)

ExternalLinkItem.create(
  resume: resume_92,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate92'
)

ExternalLinkItem.create(
  resume: resume_92,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate92'
)

ReferenceItem.create(
  resume: resume_92,
  name: 'David Kim',
  position: 'UX Director',
  company: 'UX Design Studio',
  mobile: '+1 555 0092',
  kind: :job
)

ReferenceItem.create(
  resume: resume_92,
  name: 'Lisa Rodriguez',
  position: 'Design Manager',
  company: 'Digital Experience Lab',
  mobile: '+1 555 0092',
  kind: :personal
)

# Candidate 93
candidate_93 = Candidate.new(email: 'candidate_93@simplestresumes.com', password: password)
candidate_93.skip_confirmation!
candidate_93.save

resume_93 = Resume.create(
  candidate_id: candidate_93.id,
  name: 'James Wilson',
  email: candidate_93.email,
  mobile: '+1 555 0093',
  location: 'Fargo, ND',
  about_me: 'Strategic business consultant with expertise in process improvement and organizational development. I help organizations optimize performance and achieve growth objectives.'
)

EducationItem.create(
  resume_id: resume_93.id,
  name: 'Business Administration',
  institute: 'North Dakota State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_93.id,
  name: 'Management Consulting Certification',
  institute: 'McKinsey',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_93,
  name: 'Business Consulting',
  kind: :primary
)

SkillItem.create(
  resume: resume_93,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_93,
  name: 'Organizational Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_93,
  name: 'Change Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_93,
  name: 'Performance Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_93,
  position: 'Senior Business Consultant',
  company: 'Strategic Consulting Group',
  location: 'Fargo, ND',
  start_month: 11,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led strategic consulting engagements for Fortune 500 companies, delivering solutions that improved operational efficiency by 50% and increased profitability by 35%. Developed comprehensive business strategies and organizational development plans that supported long-term growth objectives. Managed client relationships and project teams, ensuring successful delivery of consulting services and measurable business outcomes.'
)

WorkExperienceItem.create(
  resume: resume_93,
  position: 'Business Consultant',
  company: 'Management Solutions Pro',
  location: 'Fargo, ND',
  start_month: 5,
  start_year: 2020,
  end_month: 10,
  end_year: 2021,
  description: 'Provided business consulting services to various client organizations, analyzing business processes and developing improvement recommendations. Conducted organizational assessments and supported strategic planning initiatives. Worked with client teams to implement recommended changes and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_93,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate93'
)

ReferenceItem.create(
  resume: resume_93,
  name: 'Sarah Davis',
  position: 'Consulting Director',
  company: 'Strategic Consulting Group',
  mobile: '+1 555 0093',
  kind: :job
)

ReferenceItem.create(
  resume: resume_93,
  name: 'David Brown',
  position: 'Senior Consultant',
  company: 'Management Solutions Pro',
  mobile: '+1 555 0093',
  kind: :personal
)

# Candidate 94
candidate_94 = Candidate.new(email: 'candidate_94@simplestresumes.com', password: password)
candidate_94.skip_confirmation!
candidate_94.save

resume_94 = Resume.create(
  candidate_id: candidate_94.id,
  name: 'Michelle Anderson',
  email: candidate_94.email,
  mobile: '+1 555 0094',
  location: 'Columbus, OH',
  about_me: 'Creative content strategist with expertise in storytelling and audience engagement. I develop content that connects with people and drives meaningful results.'
)

EducationItem.create(
  resume_id: resume_94.id,
  name: 'Communications',
  institute: 'Ohio State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_94.id,
  name: 'Content Strategy Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_94,
  name: 'Content Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_94,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_94,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_94,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_94,
  name: 'SEO',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_94,
  position: 'Senior Content Strategist',
  company: 'Content Strategy Pro',
  location: 'Columbus, OH',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content strategy initiatives for major brands and organizations, developing comprehensive content plans that increased audience engagement by 60% and improved brand recognition across multiple platforms. Created content strategies that aligned with business objectives and target audience preferences, ensuring consistent messaging and brand voice. Collaborated with creative teams to develop engaging content that effectively communicated brand messages and drove desired customer actions.'
)

WorkExperienceItem.create(
  resume: resume_94,
  position: 'Content Strategist',
  company: 'Creative Content Agency',
  location: 'Columbus, OH',
  start_month: 12,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Developed content strategies for client campaigns and managed content creation processes. Created engaging content for various platforms and conducted content performance analysis to optimize strategies. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_94,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate94'
)

ExternalLinkItem.create(
  resume: resume_94,
  name: 'Content Portfolio',
  url: 'https://candidate94-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_94,
  name: 'Robert Johnson',
  position: 'Content Director',
  company: 'Content Strategy Pro',
  mobile: '+1 555 0094',
  kind: :job
)

ReferenceItem.create(
  resume: resume_94,
  name: 'Michael Chen',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0094',
  kind: :personal
)

# Candidate 95
candidate_95 = Candidate.new(email: 'candidate_95@simplestresumes.com', password: password)
candidate_95.skip_confirmation!
candidate_95.save

resume_95 = Resume.create(
  candidate_id: candidate_95.id,
  name: 'Kevin Brown',
  email: candidate_95.email,
  mobile: '+1 555 0095',
  location: 'Cleveland, OH',
  about_me: 'Experienced data scientist with expertise in machine learning and predictive analytics. I develop models that provide insights and drive data-driven decision making.'
)

EducationItem.create(
  resume_id: resume_95.id,
  name: 'Data Science',
  institute: 'Case Western Reserve University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_95.id,
  name: 'Machine Learning Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_95,
  name: 'Data Science',
  kind: :primary
)

SkillItem.create(
  resume: resume_95,
  name: 'Machine Learning',
  kind: :primary
)

SkillItem.create(
  resume: resume_95,
  name: 'Predictive Analytics',
  kind: :primary
)

SkillItem.create(
  resume: resume_95,
  name: 'Python',
  kind: :secondary
)

SkillItem.create(
  resume: resume_95,
  name: 'R',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_95,
  position: 'Senior Data Scientist',
  company: 'Data Science Lab',
  location: 'Cleveland, OH',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data science initiatives that delivered actionable insights and predictive models for business decision-making, resulting in 30% improvement in operational efficiency and 25% increase in revenue. Developed machine learning models for customer segmentation, churn prediction, and demand forecasting that supported strategic business planning. Collaborated with business stakeholders to understand data needs and translate complex analytical findings into clear, actionable recommendations.'
)

WorkExperienceItem.create(
  resume: resume_95,
  position: 'Data Scientist',
  company: 'Analytics Solutions Inc',
  location: 'Cleveland, OH',
  start_month: 7,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Developed machine learning models and conducted data analysis to support business decision-making processes. Created predictive models and conducted statistical analysis to identify trends and opportunities. Worked with business teams to implement data-driven solutions and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_95,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate95'
)

ExternalLinkItem.create(
  resume: resume_95,
  name: 'GitHub',
  url: 'https://github.com/candidate95'
)

ReferenceItem.create(
  resume: resume_95,
  name: 'Rachel Green',
  position: 'Data Science Director',
  company: 'Data Science Lab',
  mobile: '+1 555 0095',
  kind: :job
)

ReferenceItem.create(
  resume: resume_95,
  name: 'Kevin Martinez',
  position: 'Senior Scientist',
  company: 'Analytics Solutions Inc',
  mobile: '+1 555 0095',
  kind: :personal
)

# Candidate 96
candidate_96 = Candidate.new(email: 'candidate_96@simplestresumes.com', password: password)
candidate_96.skip_confirmation!
candidate_96.save

resume_96 = Resume.create(
  candidate_id: candidate_96.id,
  name: 'Amanda Davis',
  email: candidate_96.email,
  mobile: '+1 555 0096',
  location: 'Cincinnati, OH',
  about_me: 'Strategic marketing manager with expertise in campaign development and brand growth. I develop marketing strategies that increase market share and customer engagement.'
)

EducationItem.create(
  resume_id: resume_96.id,
  name: 'Marketing',
  institute: 'University of Cincinnati',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_96.id,
  name: 'Digital Marketing Certification',
  institute: 'HubSpot Academy',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_96,
  name: 'Marketing Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_96,
  name: 'Campaign Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_96,
  name: 'Brand Growth',
  kind: :primary
)

SkillItem.create(
  resume: resume_96,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_96,
  name: 'Customer Engagement',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_96,
  position: 'Senior Marketing Manager',
  company: 'Strategic Marketing Group',
  location: 'Cincinnati, OH',
  start_month: 10,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive marketing strategies for major brands, developing campaigns that increased market share by 40% and improved customer engagement by 55% across multiple channels. Managed integrated marketing campaigns from concept to execution, ensuring consistent messaging and optimal performance across all touchpoints. Conducted market research and competitive analysis to inform marketing decisions and identify opportunities for growth and market expansion.'
)

WorkExperienceItem.create(
  resume: resume_96,
  position: 'Marketing Manager',
  company: 'Marketing Solutions Pro',
  location: 'Cincinnati, OH',
  start_month: 4,
  start_year: 2021,
  end_month: 9,
  end_year: 2022,
  description: 'Developed marketing strategies for client campaigns and managed marketing initiatives across various channels. Conducted market research and competitive analysis to inform marketing decisions. Collaborated with creative teams to develop marketing materials and ensure brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_96,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate96'
)

ExternalLinkItem.create(
  resume: resume_96,
  name: 'Marketing Blog',
  url: 'https://candidate96-marketing-blog.com'
)

ReferenceItem.create(
  resume: resume_96,
  name: 'Christopher Lee',
  position: 'Marketing Director',
  company: 'Strategic Marketing Group',
  mobile: '+1 555 0096',
  kind: :job
)

ReferenceItem.create(
  resume: resume_96,
  name: 'Jennifer Davis',
  position: 'Brand Manager',
  company: 'Marketing Solutions Pro',
  mobile: '+1 555 0096',
  kind: :personal
)

# Candidate 97
candidate_97 = Candidate.new(email: 'candidate_97@simplestresumes.com', password: password)
candidate_97.skip_confirmation!
candidate_97.save

resume_97 = Resume.create(
  candidate_id: candidate_97.id,
  name: 'Daniel Wilson',
  email: candidate_97.email,
  mobile: '+1 555 0097',
  location: 'Toledo, OH',
  about_me: 'Innovative product strategist with expertise in market analysis and product development. I develop strategies that create competitive advantages and drive market success.'
)

EducationItem.create(
  resume_id: resume_97.id,
  name: 'Product Strategy',
  institute: 'University of Toledo',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_97.id,
  name: 'Product Strategy Certification',
  institute: 'Product School',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_97,
  name: 'Product Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_97,
  name: 'Market Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_97,
  name: 'Product Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_97,
  name: 'Competitive Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_97,
  name: 'Strategic Planning',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_97,
  position: 'Senior Product Strategist',
  company: 'Product Strategy Group',
  location: 'Toledo, OH',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy initiatives for major organizations, developing comprehensive strategies that created competitive advantages and drove market success. Conducted market analysis and competitive research to identify opportunities and inform product development decisions. Collaborated with product and business teams to develop strategic roadmaps that aligned with business objectives and market opportunities.'
)

WorkExperienceItem.create(
  resume: resume_97,
  position: 'Product Strategist',
  company: 'Strategic Products Inc',
  location: 'Toledo, OH',
  start_month: 11,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Developed product strategies and conducted market analysis to inform product development decisions. Conducted competitive analysis and market research to identify opportunities. Worked with product teams to develop strategic roadmaps and ensure alignment with business objectives.'
)

ExternalLinkItem.create(
  resume: resume_97,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate97'
)

ExternalLinkItem.create(
  resume: resume_97,
  name: 'Strategy Portfolio',
  url: 'https://candidate97-strategy-portfolio.com'
)

ReferenceItem.create(
  resume: resume_97,
  name: 'Jessica Taylor',
  position: 'Product Strategy Director',
  company: 'Product Strategy Group',
  mobile: '+1 555 0097',
  kind: :job
)

ReferenceItem.create(
  resume: resume_97,
  name: 'Mark Johnson',
  position: 'Strategy Manager',
  company: 'Strategic Products Inc',
  mobile: '+1 555 0097',
  kind: :personal
)

# Candidate 98
candidate_98 = Candidate.new(email: 'candidate_98@simplestresumes.com', password: password)
candidate_98.skip_confirmation!
candidate_98.save

resume_98 = Resume.create(
  candidate_id: candidate_98.id,
  name: 'Lisa Brown',
  email: candidate_98.email,
  mobile: '+1 555 0098',
  location: 'Akron, OH',
  about_me: 'Creative graphic designer with expertise in visual communication and brand identity. I create compelling designs that effectively communicate messages and enhance brand recognition.'
)

EducationItem.create(
  resume_id: resume_98.id,
  name: 'Graphic Design',
  institute: 'University of Akron',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_98.id,
  name: 'Adobe Creative Suite Certification',
  institute: 'Adobe',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_98,
  name: 'Graphic Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_98,
  name: 'Visual Communication',
  kind: :primary
)

SkillItem.create(
  resume: resume_98,
  name: 'Brand Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_98,
  name: 'Typography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_98,
  name: 'Layout Design',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_98,
  position: 'Senior Graphic Designer',
  company: 'Creative Design Studio',
  location: 'Akron, OH',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led creative design projects for major brands and organizations, developing visual identities and marketing materials that increased brand recognition by 55% and improved customer engagement. Managed design teams and creative processes, ensuring high-quality deliverables that met client objectives and brand guidelines. Collaborated with marketing teams to develop cohesive visual strategies that supported business goals and enhanced brand presence.'
)

WorkExperienceItem.create(
  resume: resume_98,
  position: 'Graphic Designer',
  company: 'Visual Design Agency',
  location: 'Akron, OH',
  start_month: 8,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Created graphic designs for various client projects including logos, marketing materials, and digital assets. Worked with creative teams to develop visual concepts and ensure brand consistency. Managed multiple design projects and met client deadlines.'
)

ExternalLinkItem.create(
  resume: resume_98,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate98'
)

ExternalLinkItem.create(
  resume: resume_98,
  name: 'Behance',
  url: 'https://behance.net/candidate98'
)

ReferenceItem.create(
  resume: resume_98,
  name: 'Michael Rodriguez',
  position: 'Creative Director',
  company: 'Creative Design Studio',
  mobile: '+1 555 0098',
  kind: :job
)

ReferenceItem.create(
  resume: resume_98,
  name: 'Sarah Kim',
  position: 'Design Manager',
  company: 'Visual Design Agency',
  mobile: '+1 555 0098',
  kind: :personal
)

# Candidate 99
candidate_99 = Candidate.new(email: 'candidate_99@simplestresumes.com', password: password)
candidate_99.skip_confirmation!
candidate_99.save

resume_99 = Resume.create(
  candidate_id: candidate_99.id,
  name: 'Robert Anderson',
  email: candidate_99.email,
  mobile: '+1 555 0099',
  location: 'Dayton, OH',
  about_me: 'Experienced business analyst with expertise in process optimization and data-driven decision making. I help organizations improve efficiency and achieve operational excellence.'
)

EducationItem.create(
  resume_id: resume_99.id,
  name: 'Business Analysis',
  institute: 'University of Dayton',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_99.id,
  name: 'Six Sigma Green Belt',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_99,
  name: 'Business Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_99,
  name: 'Process Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_99,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_99,
  name: 'Requirements Gathering',
  kind: :secondary
)

SkillItem.create(
  resume: resume_99,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_99,
  position: 'Senior Business Analyst',
  company: 'Business Optimization Group',
  location: 'Dayton, OH',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business analysis initiatives that identified and implemented process improvements resulting in 45% reduction in operational costs and 55% improvement in process efficiency. Conducted comprehensive business process analysis and developed recommendations for optimization that supported organizational goals and improved customer experience. Managed stakeholder relationships and facilitated workshops to gather requirements and ensure alignment on business objectives.'
)

WorkExperienceItem.create(
  resume: resume_99,
  position: 'Business Analyst',
  company: 'Process Solutions Inc',
  location: 'Dayton, OH',
  start_month: 2,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Analyzed business processes and gathered requirements for system improvements and process optimization projects. Created business process documentation and worked with stakeholders to ensure accurate requirement definition. Supported project teams in implementing process improvements and system enhancements.'
)

ExternalLinkItem.create(
  resume: resume_99,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate99'
)

ReferenceItem.create(
  resume: resume_99,
  name: 'Amanda Rodriguez',
  position: 'Business Analysis Director',
  company: 'Business Optimization Group',
  mobile: '+1 555 0099',
  kind: :job
)

ReferenceItem.create(
  resume: resume_99,
  name: 'Carlos Mendez',
  position: 'Process Manager',
  company: 'Process Solutions Inc',
  mobile: '+1 555 0099',
  kind: :personal
)

# Candidate 100
candidate_100 = Candidate.new(email: 'candidate_100@simplestresumes.com', password: password)
candidate_100.skip_confirmation!
candidate_100.save

resume_100 = Resume.create(
  candidate_id: candidate_100.id,
  name: 'Jennifer Wilson',
  email: candidate_100.email,
  mobile: '+1 555 0100',
  location: 'Parma, OH',
  about_me: 'Creative marketing coordinator with expertise in campaign execution and brand management. I coordinate marketing efforts that drive results and enhance brand presence.'
)

EducationItem.create(
  resume_id: resume_100.id,
  name: 'Marketing',
  institute: 'Cleveland State University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_100.id,
  name: 'Digital Marketing Certification',
  institute: 'Google Digital Garage',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_100,
  name: 'Campaign Execution',
  kind: :primary
)

SkillItem.create(
  resume: resume_100,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_100,
  name: 'Marketing Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_100,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_100,
  name: 'Social Media',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_100,
  position: 'Senior Marketing Coordinator',
  company: 'Marketing Excellence Corp',
  location: 'Parma, OH',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated comprehensive marketing campaigns for major brands, managing multiple channels and ensuring consistent messaging that increased brand awareness by 50% and improved customer engagement. Developed and executed marketing strategies that aligned with business objectives and target audience preferences. Coordinated with creative teams, media partners, and stakeholders to ensure successful campaign delivery and measurable results.'
)

WorkExperienceItem.create(
  resume: resume_100,
  position: 'Marketing Coordinator',
  company: 'Creative Marketing Solutions',
  location: 'Parma, OH',
  start_month: 1,
  start_year: 2021,
  end_month: 6,
  end_year: 2022,
  description: 'Coordinated marketing campaigns and supported brand management initiatives for various client accounts. Assisted with content creation and social media management. Coordinated with creative teams and ensured campaign deliverables met quality standards.'
)

ExternalLinkItem.create(
  resume: resume_100,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate100'
)

ExternalLinkItem.create(
  resume: resume_100,
  name: 'Marketing Portfolio',
  url: 'https://candidate100-marketing-portfolio.com'
)

ReferenceItem.create(
  resume: resume_100,
  name: 'Michael Chen',
  position: 'Marketing Director',
  company: 'Marketing Excellence Corp',
  mobile: '+1 555 0100',
  kind: :job
)

ReferenceItem.create(
  resume: resume_100,
  name: 'Lisa Rodriguez',
  position: 'Brand Manager',
  company: 'Creative Marketing Solutions',
  mobile: '+1 555 0100',
  kind: :personal
)

Candidate.set_callback(:create, :after, :create_stripe_customer)

# Candidate 101
candidate_101 = Candidate.new(email: 'candidate_101@simplestresumes.com', password: password)
candidate_101.skip_confirmation!
candidate_101.save

resume_101 = Resume.create(
  candidate_id: candidate_101.id,
  name: 'Ryan Johnson',
  email: candidate_101.email,
  mobile: '+1 555 0101',
  location: 'Oklahoma City, OK',
  about_me: 'Innovative software engineer with expertise in full-stack development and system architecture. I build robust applications that solve complex problems efficiently.'
)

EducationItem.create(
  resume_id: resume_101.id,
  name: 'Computer Science',
  institute: 'University of Oklahoma',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_101.id,
  name: 'Full-Stack Development Certification',
  institute: 'Udemy',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_101,
  name: 'Full-Stack Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_101,
  name: 'Software Engineering',
  kind: :primary
)

SkillItem.create(
  resume: resume_101,
  name: 'System Architecture',
  kind: :primary
)

SkillItem.create(
  resume: resume_101,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_101,
  name: 'Python',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_101,
  position: 'Senior Software Engineer',
  company: 'Tech Solutions Corp',
  location: 'Oklahoma City, OK',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led full-stack development initiatives for enterprise applications serving over 180,000 users, implementing scalable solutions that improved system performance by 45% and reduced development time by 25%. Designed and developed system architectures that enhanced application reliability and enabled rapid feature development. Collaborated with cross-functional teams to deliver high-quality software solutions that met business requirements and exceeded user expectations.'
)

WorkExperienceItem.create(
  resume: resume_101,
  position: 'Software Engineer',
  company: 'Digital Development Lab',
  location: 'Oklahoma City, OK',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Developed full-stack applications and software solutions for various client projects. Implemented system architectures and ensured code quality and performance. Worked with development teams to deliver software solutions that met client requirements.'
)

ExternalLinkItem.create(
  resume: resume_101,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate101'
)

ExternalLinkItem.create(
  resume: resume_101,
  name: 'GitHub',
  url: 'https://github.com/candidate101'
)

ReferenceItem.create(
  resume: resume_101,
  name: 'Jennifer Lee',
  position: 'Engineering Director',
  company: 'Tech Solutions Corp',
  mobile: '+1 555 0101',
  kind: :job
)

ReferenceItem.create(
  resume: resume_101,
  name: 'Michael Chen',
  position: 'Senior Engineer',
  company: 'Digital Development Lab',
  mobile: '+1 555 0101',
  kind: :personal
)

# Candidate 102
candidate_102 = Candidate.new(email: 'candidate_102@simplestresumes.com', password: password)
candidate_102.skip_confirmation!
candidate_102.save

resume_102 = Resume.create(
  candidate_id: candidate_102.id,
  name: 'Amanda Wilson',
  email: candidate_102.email,
  mobile: '+1 555 0102',
  location: 'Tulsa, OK',
  about_me: 'Creative brand manager with expertise in brand strategy and visual identity. I develop comprehensive brand systems that strengthen market presence and customer loyalty.'
)

EducationItem.create(
  resume_id: resume_102.id,
  name: 'Brand Management',
  institute: 'University of Tulsa',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_102.id,
  name: 'Brand Strategy Certification',
  institute: 'AMA',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_102,
  name: 'Brand Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_102,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_102,
  name: 'Visual Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_102,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_102,
  name: 'Creative Direction',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_102,
  position: 'Senior Brand Manager',
  company: 'Brand Excellence Group',
  location: 'Tulsa, OK',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive brand management initiatives for major organizations, developing brand strategies and visual identities that increased brand recognition by 50% and improved customer loyalty scores. Managed brand positioning and messaging development that differentiated clients in competitive markets and enhanced brand equity. Collaborated with creative teams to ensure consistent brand expression across all touchpoints and marketing channels.'
)

WorkExperienceItem.create(
  resume: resume_102,
  position: 'Brand Manager',
  company: 'Creative Brand Solutions',
  location: 'Tulsa, OK',
  start_month: 2,
  start_year: 2021,
  end_month: 7,
  end_year: 2022,
  description: 'Managed brand development and positioning for various client organizations. Developed brand strategies and ensured consistent brand expression across marketing materials. Worked with creative teams to develop visual identities and brand guidelines.'
)

ExternalLinkItem.create(
  resume: resume_102,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate102'
)

ExternalLinkItem.create(
  resume: resume_102,
  name: 'Brand Portfolio',
  url: 'https://candidate102-brand-portfolio.com'
)

ReferenceItem.create(
  resume: resume_102,
  name: 'Christopher Lee',
  position: 'Brand Director',
  company: 'Brand Excellence Group',
  mobile: '+1 555 0102',
  kind: :job
)

ReferenceItem.create(
  resume: resume_102,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Brand Solutions',
  mobile: '+1 555 0102',
  kind: :personal
)

# Candidate 103
candidate_103 = Candidate.new(email: 'candidate_103@simplestresumes.com', password: password)
candidate_103.skip_confirmation!
candidate_103.save

resume_103 = Resume.create(
  candidate_id: candidate_103.id,
  name: 'Daniel Brown',
  email: candidate_103.email,
  mobile: '+1 555 0103',
  location: 'Portland, OR',
  about_me: 'Experienced project coordinator with expertise in team management and delivery optimization. I coordinate projects to ensure successful completion and stakeholder satisfaction.'
)

EducationItem.create(
  resume_id: resume_103.id,
  name: 'Project Management',
  institute: 'Portland State University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_103.id,
  name: 'PMP Certification',
  institute: 'Project Management Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_103,
  name: 'Project Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_103,
  name: 'Team Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_103,
  name: 'Delivery Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_103,
  name: 'Stakeholder Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_103,
  name: 'Risk Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_103,
  position: 'Senior Project Coordinator',
  company: 'Project Excellence Corp',
  location: 'Portland, OR',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated complex projects with budgets exceeding $2.2M, ensuring successful delivery within scope, budget, and timeline constraints while maintaining high quality standards. Managed cross-functional project teams and coordinated resources to ensure project milestones were met and objectives achieved. Developed and maintained project schedules, coordinated stakeholder communications, and managed project risks to ensure successful outcomes.'
)

WorkExperienceItem.create(
  resume: resume_103,
  position: 'Project Coordinator',
  company: 'Project Solutions Pro',
  location: 'Portland, OR',
  start_month: 10,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Coordinated project activities and supported project managers in delivering successful project outcomes. Managed project schedules and coordinated team resources. Assisted with stakeholder communications and project documentation.'
)

ExternalLinkItem.create(
  resume: resume_103,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate103'
)

ReferenceItem.create(
  resume: resume_103,
  name: 'Sarah Johnson',
  position: 'Project Director',
  company: 'Project Excellence Corp',
  mobile: '+1 555 0103',
  kind: :job
)

ReferenceItem.create(
  resume: resume_103,
  name: 'Robert Wilson',
  position: 'Senior PM',
  company: 'Project Solutions Pro',
  mobile: '+1 555 0103',
  kind: :personal
)

# Candidate 104
candidate_104 = Candidate.new(email: 'candidate_104@simplestresumes.com', password: password)
candidate_104.skip_confirmation!
candidate_104.save

resume_104 = Resume.create(
  candidate_id: candidate_104.id,
  name: 'Nicole Davis',
  email: candidate_104.email,
  mobile: '+1 555 0104',
  location: 'Salem, OR',
  about_me: 'Innovative UX designer with expertise in user research and interface design. I create intuitive user experiences that delight users and drive engagement.'
)

EducationItem.create(
  resume_id: resume_104.id,
  name: 'User Experience Design',
  institute: 'Willamette University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_104.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_104,
  name: 'UX Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_104,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_104,
  name: 'Interface Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_104,
  name: 'Wireframing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_104,
  name: 'Prototyping',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_104,
  position: 'Senior UX Designer',
  company: 'UX Design Studio',
  location: 'Salem, OR',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led UX design initiatives for digital products serving millions of users, resulting in 60% improvement in user satisfaction scores and 40% reduction in user support requests. Conducted comprehensive user research including interviews, surveys, and usability testing to inform design decisions and validate solutions. Developed user personas, journey maps, and design systems that ensured consistent and intuitive user experiences across all product touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_104,
  position: 'UX Designer',
  company: 'Digital Experience Lab',
  location: 'Salem, OR',
  start_month: 6,
  start_year: 2020,
  end_month: 11,
  end_year: 2021,
  description: 'Designed user interfaces and user experiences for web and mobile applications. Conducted user research and usability testing to inform design decisions. Created wireframes, prototypes, and design specifications for development teams.'
)

ExternalLinkItem.create(
  resume: resume_104,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate104'
)

ExternalLinkItem.create(
  resume: resume_104,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate104'
)

ReferenceItem.create(
  resume: resume_104,
  name: 'David Kim',
  position: 'UX Director',
  company: 'UX Design Studio',
  mobile: '+1 555 0104',
  kind: :job
)

ReferenceItem.create(
  resume: resume_104,
  name: 'Lisa Rodriguez',
  position: 'Design Manager',
  company: 'Digital Experience Lab',
  mobile: '+1 555 0104',
  kind: :personal
)

# Candidate 105
candidate_105 = Candidate.new(email: 'candidate_105@simplestresumes.com', password: password)
candidate_105.skip_confirmation!
candidate_105.save

resume_105 = Resume.create(
  candidate_id: candidate_105.id,
  name: 'James Johnson',
  email: candidate_105.email,
  mobile: '+1 555 0105',
  location: 'Eugene, OR',
  about_me: 'Strategic business consultant with expertise in process improvement and organizational development. I help organizations optimize performance and achieve growth objectives.'
)

EducationItem.create(
  resume_id: resume_105.id,
  name: 'Business Administration',
  institute: 'University of Oregon',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_105.id,
  name: 'Management Consulting Certification',
  institute: 'McKinsey',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_105,
  name: 'Business Consulting',
  kind: :primary
)

SkillItem.create(
  resume: resume_105,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_105,
  name: 'Organizational Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_105,
  name: 'Change Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_105,
  name: 'Performance Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_105,
  position: 'Senior Business Consultant',
  company: 'Strategic Consulting Group',
  location: 'Eugene, OR',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led strategic consulting engagements for Fortune 500 companies, delivering solutions that improved operational efficiency by 55% and increased profitability by 40%. Developed comprehensive business strategies and organizational development plans that supported long-term growth objectives. Managed client relationships and project teams, ensuring successful delivery of consulting services and measurable business outcomes.'
)

WorkExperienceItem.create(
  resume: resume_105,
  position: 'Business Consultant',
  company: 'Management Solutions Pro',
  location: 'Eugene, OR',
  start_month: 1,
  start_year: 2021,
  end_month: 6,
  end_year: 2022,
  description: 'Provided business consulting services to various client organizations, analyzing business processes and developing improvement recommendations. Conducted organizational assessments and supported strategic planning initiatives. Worked with client teams to implement recommended changes and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_105,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate105'
)

ReferenceItem.create(
  resume: resume_105,
  name: 'Sarah Davis',
  position: 'Consulting Director',
  company: 'Strategic Consulting Group',
  mobile: '+1 555 0105',
  kind: :job
)

ReferenceItem.create(
  resume: resume_105,
  name: 'David Brown',
  position: 'Senior Consultant',
  company: 'Management Solutions Pro',
  mobile: '+1 555 0105',
  kind: :personal
)

# Candidate 106
candidate_106 = Candidate.new(email: 'candidate_106@simplestresumes.com', password: password)
candidate_106.skip_confirmation!
candidate_106.save

resume_106 = Resume.create(
  candidate_id: candidate_106.id,
  name: 'Stephanie Wilson',
  email: candidate_106.email,
  mobile: '+1 555 0106',
  location: 'Philadelphia, PA',
  about_me: 'Creative content strategist with expertise in storytelling and audience engagement. I develop content that connects with people and drives meaningful results.'
)

EducationItem.create(
  resume_id: resume_106.id,
  name: 'Communications',
  institute: 'Temple University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_106.id,
  name: 'Content Strategy Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_106,
  name: 'Content Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_106,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_106,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_106,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_106,
  name: 'SEO',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_106,
  position: 'Senior Content Strategist',
  company: 'Content Strategy Pro',
  location: 'Philadelphia, PA',
  start_month: 3,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content strategy initiatives for major brands and organizations, developing comprehensive content plans that increased audience engagement by 65% and improved brand recognition across multiple platforms. Created content strategies that aligned with business objectives and target audience preferences, ensuring consistent messaging and brand voice. Collaborated with creative teams to develop engaging content that effectively communicated brand messages and drove desired customer actions.'
)

WorkExperienceItem.create(
  resume: resume_106,
  position: 'Content Strategist',
  company: 'Creative Content Agency',
  location: 'Philadelphia, PA',
  start_month: 8,
  start_year: 2020,
  end_month: 2,
  end_year: 2022,
  description: 'Developed content strategies for client campaigns and managed content creation processes. Created engaging content for various platforms and conducted content performance analysis to optimize strategies. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_106,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate106'
)

ExternalLinkItem.create(
  resume: resume_106,
  name: 'Content Portfolio',
  url: 'https://candidate106-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_106,
  name: 'Robert Johnson',
  position: 'Content Director',
  company: 'Content Strategy Pro',
  mobile: '+1 555 0106',
  kind: :job
)

ReferenceItem.create(
  resume: resume_106,
  name: 'Michael Chen',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0106',
  kind: :personal
)

# Candidate 107
candidate_107 = Candidate.new(email: 'candidate_107@simplestresumes.com', password: password)
candidate_107.skip_confirmation!
candidate_107.save

resume_107 = Resume.create(
  candidate_id: candidate_107.id,
  name: 'Kevin Anderson',
  email: candidate_107.email,
  mobile: '+1 555 0107',
  location: 'Pittsburgh, PA',
  about_me: 'Experienced data scientist with expertise in machine learning and predictive analytics. I develop models that provide insights and drive data-driven decision making.'
)

EducationItem.create(
  resume_id: resume_107.id,
  name: 'Data Science',
  institute: 'University of Pittsburgh',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_107.id,
  name: 'Machine Learning Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_107,
  name: 'Data Science',
  kind: :primary
)

SkillItem.create(
  resume: resume_107,
  name: 'Machine Learning',
  kind: :primary
)

SkillItem.create(
  resume: resume_107,
  name: 'Predictive Analytics',
  kind: :primary
)

SkillItem.create(
  resume: resume_107,
  name: 'Python',
  kind: :secondary
)

SkillItem.create(
  resume: resume_107,
  name: 'R',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_107,
  position: 'Senior Data Scientist',
  company: 'Data Science Lab',
  location: 'Pittsburgh, PA',
  start_month: 11,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led data science initiatives that delivered actionable insights and predictive models for business decision-making, resulting in 35% improvement in operational efficiency and 30% increase in revenue. Developed machine learning models for customer segmentation, churn prediction, and demand forecasting that supported strategic business planning. Collaborated with business stakeholders to understand data needs and translate complex analytical findings into clear, actionable recommendations.'
)

WorkExperienceItem.create(
  resume: resume_107,
  position: 'Data Scientist',
  company: 'Analytics Solutions Inc',
  location: 'Pittsburgh, PA',
  start_month: 5,
  start_year: 2020,
  end_month: 10,
  end_year: 2021,
  description: 'Developed machine learning models and conducted data analysis to support business decision-making processes. Created predictive models and conducted statistical analysis to identify trends and opportunities. Worked with business teams to implement data-driven solutions and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_107,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate107'
)

ExternalLinkItem.create(
  resume: resume_107,
  name: 'GitHub',
  url: 'https://github.com/candidate107'
)

ReferenceItem.create(
  resume: resume_107,
  name: 'Rachel Green',
  position: 'Data Science Director',
  company: 'Data Science Lab',
  mobile: '+1 555 0107',
  kind: :job
)

ReferenceItem.create(
  resume: resume_107,
  name: 'Kevin Martinez',
  position: 'Senior Scientist',
  company: 'Analytics Solutions Inc',
  mobile: '+1 555 0107',
  kind: :personal
)

# Candidate 108
candidate_108 = Candidate.new(email: 'candidate_108@simplestresumes.com', password: password)
candidate_108.skip_confirmation!
candidate_108.save

resume_108 = Resume.create(
  candidate_id: candidate_108.id,
  name: 'Michelle Davis',
  email: candidate_108.email,
  mobile: '+1 555 0108',
  location: 'Allentown, PA',
  about_me: 'Strategic marketing manager with expertise in campaign development and brand growth. I develop marketing strategies that increase market share and customer engagement.'
)

EducationItem.create(
  resume_id: resume_108.id,
  name: 'Marketing',
  institute: 'Lehigh University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_108.id,
  name: 'Digital Marketing Certification',
  institute: 'HubSpot Academy',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_108,
  name: 'Marketing Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_108,
  name: 'Campaign Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_108,
  name: 'Brand Growth',
  kind: :primary
)

SkillItem.create(
  resume: resume_108,
  name: 'Market Research',
  kind: :secondary
)

SkillItem.create(
  resume: resume_108,
  name: 'Customer Engagement',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_108,
  position: 'Senior Marketing Manager',
  company: 'Strategic Marketing Group',
  location: 'Allentown, PA',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led comprehensive marketing strategies for major brands, developing campaigns that increased market share by 45% and improved customer engagement by 60% across multiple channels. Managed integrated marketing campaigns from concept to execution, ensuring consistent messaging and optimal performance across all touchpoints. Conducted market research and competitive analysis to inform marketing decisions and identify opportunities for growth and market expansion.'
)

WorkExperienceItem.create(
  resume: resume_108,
  position: 'Marketing Manager',
  company: 'Marketing Solutions Pro',
  location: 'Allentown, PA',
  start_month: 12,
  start_year: 2020,
  end_month: 5,
  end_year: 2022,
  description: 'Developed marketing strategies for client campaigns and managed marketing initiatives across various channels. Conducted market research and competitive analysis to inform marketing decisions. Collaborated with creative teams to develop marketing materials and ensure brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_108,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate108'
)

ExternalLinkItem.create(
  resume: resume_108,
  name: 'Marketing Blog',
  url: 'https://candidate108-marketing-blog.com'
)

ReferenceItem.create(
  resume: resume_108,
  name: 'Christopher Lee',
  position: 'Marketing Director',
  company: 'Strategic Marketing Group',
  mobile: '+1 555 0108',
  kind: :job
)

ReferenceItem.create(
  resume: resume_108,
  name: 'Jennifer Davis',
  position: 'Brand Manager',
  company: 'Marketing Solutions Pro',
  mobile: '+1 555 0108',
  kind: :personal
)

# Candidate 109
candidate_109 = Candidate.new(email: 'candidate_109@simplestresumes.com', password: password)
candidate_109.skip_confirmation!
candidate_109.save

resume_109 = Resume.create(
  candidate_id: candidate_109.id,
  name: 'Andrew Wilson',
  email: candidate_109.email,
  mobile: '+1 555 0109',
  location: 'Erie, PA',
  about_me: 'Innovative product strategist with expertise in market analysis and product development. I develop strategies that create competitive advantages and drive market success.'
)

EducationItem.create(
  resume_id: resume_109.id,
  name: 'Product Strategy',
  institute: 'Gannon University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_109.id,
  name: 'Product Strategy Certification',
  institute: 'Product School',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_109,
  name: 'Product Strategy',
  kind: :primary
)

SkillItem.create(
  resume: resume_109,
  name: 'Market Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_109,
  name: 'Product Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_109,
  name: 'Competitive Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_109,
  name: 'Strategic Planning',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_109,
  position: 'Senior Product Strategist',
  company: 'Product Strategy Group',
  location: 'Erie, PA',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy initiatives for major organizations, developing comprehensive strategies that created competitive advantages and drove market success. Conducted market analysis and competitive research to identify opportunities and inform product development decisions. Collaborated with product and business teams to develop strategic roadmaps that aligned with business objectives and market opportunities.'
)

WorkExperienceItem.create(
  resume: resume_109,
  position: 'Product Strategist',
  company: 'Strategic Products Inc',
  location: 'Erie, PA',
  start_month: 3,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Developed product strategies and conducted market analysis to inform product development decisions. Conducted competitive analysis and market research to identify opportunities. Worked with product teams to develop strategic roadmaps and ensure alignment with business objectives.'
)

ExternalLinkItem.create(
  resume: resume_109,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate109'
)

ExternalLinkItem.create(
  resume: resume_109,
  name: 'Strategy Portfolio',
  url: 'https://candidate109-strategy-portfolio.com'
)

ReferenceItem.create(
  resume: resume_109,
  name: 'Jessica Taylor',
  position: 'Product Strategy Director',
  company: 'Product Strategy Group',
  mobile: '+1 555 0109',
  kind: :job
)

ReferenceItem.create(
  resume: resume_109,
  name: 'Mark Johnson',
  position: 'Strategy Manager',
  company: 'Strategic Products Inc',
  mobile: '+1 555 0109',
  kind: :personal
)

# Candidate 110
candidate_110 = Candidate.new(email: 'candidate_110@simplestresumes.com', password: password)
candidate_110.skip_confirmation!
candidate_110.save

resume_110 = Resume.create(
  candidate_id: candidate_110.id,
  name: 'Stephanie Brown',
  email: candidate_110.email,
  mobile: '+1 555 0110',
  location: 'Reading, PA',
  about_me: 'Creative graphic designer with expertise in visual communication and brand identity. I create compelling designs that effectively communicate messages and enhance brand recognition.'
)

EducationItem.create(
  resume_id: resume_110.id,
  name: 'Graphic Design',
  institute: 'Albright College',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_110.id,
  name: 'Adobe Creative Suite Certification',
  institute: 'Adobe',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_110,
  name: 'Graphic Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_110,
  name: 'Visual Communication',
  kind: :primary
)

SkillItem.create(
  resume: resume_110,
  name: 'Brand Identity',
  kind: :primary
)

SkillItem.create(
  resume: resume_110,
  name: 'Typography',
  kind: :secondary
)

SkillItem.create(
  resume: resume_110,
  name: 'Layout Design',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_110,
  position: 'Senior Graphic Designer',
  company: 'Creative Design Studio',
  location: 'Reading, PA',
  start_month: 1,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led creative design projects for major brands and organizations, developing visual identities and marketing materials that increased brand recognition by 60% and improved customer engagement. Managed design teams and creative processes, ensuring high-quality deliverables that met client objectives and brand guidelines. Collaborated with marketing teams to develop cohesive visual strategies that supported business goals and enhanced brand presence.'
)

WorkExperienceItem.create(
  resume: resume_110,
  position: 'Graphic Designer',
  company: 'Visual Design Agency',
  location: 'Reading, PA',
  start_month: 7,
  start_year: 2020,
  end_month: 12,
  end_year: 2021,
  description: 'Created graphic designs for various client projects including logos, marketing materials, and digital assets. Worked with creative teams to develop visual concepts and ensure brand consistency. Managed multiple design projects and met client deadlines.'
)

ExternalLinkItem.create(
  resume: resume_110,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate110'
)

ExternalLinkItem.create(
  resume: resume_110,
  name: 'Behance',
  url: 'https://behance.net/candidate110'
)

ReferenceItem.create(
  resume: resume_110,
  name: 'Michael Rodriguez',
  position: 'Creative Director',
  company: 'Creative Design Studio',
  mobile: '+1 555 0110',
  kind: :job
)

ReferenceItem.create(
  resume: resume_110,
  name: 'Sarah Kim',
  position: 'Design Manager',
  company: 'Visual Design Agency',
  mobile: '+1 555 0110',
  kind: :personal
)

# Candidate 111
candidate_111 = Candidate.new(email: 'candidate_111@simplestresumes.com', password: password)
candidate_111.skip_confirmation!
candidate_111.save

resume_111 = Resume.create(
  candidate_id: candidate_111.id,
  name: 'Robert Anderson',
  email: candidate_111.email,
  mobile: '+1 555 0111',
  location: 'Providence, RI',
  about_me: 'Experienced business analyst with expertise in process optimization and data-driven decision making. I help organizations improve efficiency and achieve operational excellence.'
)

EducationItem.create(
  resume_id: resume_111.id,
  name: 'Business Analysis',
  institute: 'Providence College',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_111.id,
  name: 'Six Sigma Green Belt',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_111,
  name: 'Business Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_111,
  name: 'Process Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_111,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_111,
  name: 'Requirements Gathering',
  kind: :secondary
)

SkillItem.create(
  resume: resume_111,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_111,
  position: 'Senior Business Analyst',
  company: 'Business Optimization Group',
  location: 'Providence, RI',
  start_month: 10,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business analysis initiatives that identified and implemented process improvements resulting in 50% reduction in operational costs and 60% improvement in process efficiency. Conducted comprehensive business process analysis and developed recommendations for optimization that supported organizational goals and improved customer experience. Managed stakeholder relationships and facilitated workshops to gather requirements and ensure alignment on business objectives.'
)

WorkExperienceItem.create(
  resume: resume_111,
  position: 'Business Analyst',
  company: 'Process Solutions Inc',
  location: 'Providence, RI',
  start_month: 4,
  start_year: 2021,
  end_month: 9,
  end_year: 2022,
  description: 'Analyzed business processes and gathered requirements for system improvements and process optimization projects. Created business process documentation and worked with stakeholders to ensure accurate requirement definition. Supported project teams in implementing process improvements and system enhancements.'
)

ExternalLinkItem.create(
  resume: resume_111,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate111'
)

ReferenceItem.create(
  resume: resume_111,
  name: 'Amanda Rodriguez',
  position: 'Business Analysis Director',
  company: 'Business Optimization Group',
  mobile: '+1 555 0111',
  kind: :job
)

ReferenceItem.create(
  resume: resume_111,
  name: 'Carlos Mendez',
  position: 'Process Manager',
  company: 'Process Solutions Inc',
  mobile: '+1 555 0111',
  kind: :personal
)

# Candidate 112
candidate_112 = Candidate.new(email: 'candidate_112@simplestresumes.com', password: password)
candidate_112.skip_confirmation!
candidate_112.save

resume_112 = Resume.create(
  candidate_id: candidate_112.id,
  name: 'Jennifer Wilson',
  email: candidate_112.email,
  mobile: '+1 555 0112',
  location: 'Columbia, SC',
  about_me: 'Creative marketing coordinator with expertise in campaign execution and brand management. I coordinate marketing efforts that drive results and enhance brand presence.'
)

EducationItem.create(
  resume_id: resume_112.id,
  name: 'Marketing',
  institute: 'University of South Carolina',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_112.id,
  name: 'Digital Marketing Certification',
  institute: 'Google Digital Garage',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_112,
  name: 'Campaign Execution',
  kind: :primary
)

SkillItem.create(
  resume: resume_112,
  name: 'Brand Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_112,
  name: 'Marketing Coordination',
  kind: :primary
)

SkillItem.create(
  resume: resume_112,
  name: 'Content Creation',
  kind: :secondary
)

SkillItem.create(
  resume: resume_112,
  name: 'Social Media',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_112,
  position: 'Senior Marketing Coordinator',
  company: 'Marketing Excellence Corp',
  location: 'Columbia, SC',
  start_month: 5,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Coordinated comprehensive marketing campaigns for major brands, managing multiple channels and ensuring consistent messaging that increased brand awareness by 55% and improved customer engagement. Developed and executed marketing strategies that aligned with business objectives and target audience preferences. Coordinated with creative teams, media partners, and stakeholders to ensure successful campaign delivery and measurable results.'
)

WorkExperienceItem.create(
  resume: resume_112,
  position: 'Marketing Coordinator',
  company: 'Creative Marketing Solutions',
  location: 'Columbia, SC',
  start_month: 11,
  start_year: 2020,
  end_month: 4,
  end_year: 2022,
  description: 'Coordinated marketing campaigns and supported brand management initiatives for various client accounts. Assisted with content creation and social media management. Coordinated with creative teams and ensured campaign deliverables met quality standards.'
)

ExternalLinkItem.create(
  resume: resume_112,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate112'
)

ExternalLinkItem.create(
  resume: resume_112,
  name: 'Marketing Portfolio',
  url: 'https://candidate112-marketing-portfolio.com'
)

ReferenceItem.create(
  resume: resume_112,
  name: 'Michael Chen',
  position: 'Marketing Director',
  company: 'Marketing Excellence Corp',
  mobile: '+1 555 0112',
  kind: :job
)

ReferenceItem.create(
  resume: resume_112,
  name: 'Lisa Rodriguez',
  position: 'Brand Manager',
  company: 'Creative Marketing Solutions',
  mobile: '+1 555 0112',
  kind: :personal
)

# Candidate 113
candidate_113 = Candidate.new(email: 'candidate_113@simplestresumes.com', password: password)
candidate_113.skip_confirmation!
candidate_113.save

resume_113 = Resume.create(
  candidate_id: candidate_113.id,
  name: 'Christopher Lee',
  email: candidate_113.email,
  mobile: '+1 555 0113',
  location: 'Sioux Falls, SD',
  about_me: 'Innovative web developer with expertise in front-end development and user experience. I create responsive websites that provide excellent user experiences and drive engagement.'
)

EducationItem.create(
  resume_id: resume_113.id,
  name: 'Web Development',
  institute: 'University of South Dakota',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_113.id,
  name: 'React Certification',
  institute: 'Meta',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_113,
  name: 'Front-end Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_113,
  name: 'Web Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_113,
  name: 'User Experience',
  kind: :primary
)

SkillItem.create(
  resume: resume_113,
  name: 'JavaScript',
  kind: :secondary
)

SkillItem.create(
  resume: resume_113,
  name: 'CSS',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_113,
  position: 'Senior Web Developer',
  company: 'Web Development Studio',
  location: 'Sioux Falls, SD',
  start_month: 8,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led web development projects for major clients, creating responsive websites and web applications that improved user engagement by 60% and enhanced online presence. Developed front-end solutions using modern technologies and best practices that ensured optimal performance and user experience. Collaborated with design and back-end teams to deliver cohesive web solutions that met client requirements and exceeded expectations.'
)

WorkExperienceItem.create(
  resume: resume_113,
  position: 'Web Developer',
  company: 'Digital Web Solutions',
  location: 'Sioux Falls, SD',
  start_month: 2,
  start_year: 2021,
  end_month: 7,
  end_year: 2022,
  description: 'Developed websites and web applications for various client projects. Created responsive designs and ensured cross-browser compatibility. Worked with design teams to implement visual designs and maintain code quality.'
)

ExternalLinkItem.create(
  resume: resume_113,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate113'
)

ExternalLinkItem.create(
  resume: resume_113,
  name: 'GitHub',
  url: 'https://github.com/candidate113'
)

ReferenceItem.create(
  resume: resume_113,
  name: 'Christopher Lee',
  position: 'Development Director',
  company: 'Web Development Studio',
  mobile: '+1 555 0113',
  kind: :job
)

ReferenceItem.create(
  resume: resume_113,
  name: 'David Kim',
  position: 'Senior Developer',
  company: 'Digital Web Solutions',
  mobile: '+1 555 0113',
  kind: :personal
)

# Candidate 114
candidate_114 = Candidate.new(email: 'candidate_114@simplestresumes.com', password: password)
candidate_114.skip_confirmation!
candidate_114.save

resume_114 = Resume.create(
  candidate_id: candidate_114.id,
  name: 'Nicole Johnson',
  email: candidate_114.email,
  mobile: '+1 555 0114',
  location: 'Nashville, TN',
  about_me: 'Strategic operations analyst with expertise in performance optimization and process improvement. I analyze operations to identify opportunities for enhancement and efficiency gains.'
)

EducationItem.create(
  resume_id: resume_114.id,
  name: 'Operations Management',
  institute: 'Vanderbilt University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_114.id,
  name: 'Lean Six Sigma Certification',
  institute: 'ASQ',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_114,
  name: 'Operations Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_114,
  name: 'Performance Optimization',
  kind: :primary
)

SkillItem.create(
  resume: resume_114,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_114,
  name: 'Data Analysis',
  kind: :secondary
)

SkillItem.create(
  resume: resume_114,
  name: 'Performance Metrics',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_114,
  position: 'Senior Operations Analyst',
  company: 'Operations Excellence Corp',
  location: 'Nashville, TN',
  start_month: 12,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led operations analysis initiatives that identified and implemented performance improvements resulting in 40% increase in operational efficiency and 35% reduction in costs while maintaining quality standards. Conducted comprehensive performance analysis and developed optimization strategies that supported organizational goals and improved customer satisfaction. Managed performance metrics and reporting systems that provided insights for continuous improvement and strategic decision-making.'
)

WorkExperienceItem.create(
  resume: resume_114,
  position: 'Operations Analyst',
  company: 'Performance Solutions Inc',
  location: 'Nashville, TN',
  start_month: 6,
  start_year: 2021,
  end_month: 11,
  end_year: 2021,
  description: 'Analyzed operational performance and identified opportunities for improvement and optimization. Developed performance metrics and reporting systems to support operational decision-making. Supported process improvement initiatives and performance optimization projects.'
)

ExternalLinkItem.create(
  resume: resume_114,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate114'
)

ReferenceItem.create(
  resume: resume_114,
  name: 'Jennifer Wilson',
  position: 'Operations Director',
  company: 'Operations Excellence Corp',
  mobile: '+1 555 0114',
  kind: :job
)

ReferenceItem.create(
  resume: resume_114,
  name: 'Robert Brown',
  position: 'Performance Manager',
  company: 'Performance Solutions Inc',
  mobile: '+1 555 0114',
  kind: :personal
)

# Candidate 115
candidate_115 = Candidate.new(email: 'candidate_115@simplestresumes.com', password: password)
candidate_115.skip_confirmation!
candidate_115.save

resume_115 = Resume.create(
  candidate_id: candidate_115.id,
  name: 'Michael Wilson',
  email: candidate_115.email,
  mobile: '+1 555 0115',
  location: 'Memphis, TN',
  about_me: 'Creative content creator with expertise in storytelling and audience engagement. I develop compelling content that connects with audiences and drives meaningful engagement.'
)

EducationItem.create(
  resume_id: resume_115.id,
  name: 'Communications',
  institute: 'University of Memphis',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_115.id,
  name: 'Content Creation Certification',
  institute: 'Content Marketing Institute',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_115,
  name: 'Content Creation',
  kind: :primary
)

SkillItem.create(
  resume: resume_115,
  name: 'Storytelling',
  kind: :primary
)

SkillItem.create(
  resume: resume_115,
  name: 'Audience Engagement',
  kind: :primary
)

SkillItem.create(
  resume: resume_115,
  name: 'Content Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_115,
  name: 'Creative Writing',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_115,
  position: 'Senior Content Creator',
  company: 'Content Creation Studio',
  location: 'Memphis, TN',
  start_month: 4,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led content creation initiatives for major brands and organizations, developing compelling content that increased audience engagement by 70% and improved brand recognition across multiple platforms. Created diverse content types including articles, videos, and social media posts that effectively communicated brand messages and engaged target audiences. Collaborated with marketing teams to develop content strategies that aligned with business objectives and audience preferences.'
)

WorkExperienceItem.create(
  resume: resume_115,
  position: 'Content Creator',
  company: 'Creative Content Agency',
  location: 'Memphis, TN',
  start_month: 9,
  start_year: 2020,
  end_month: 3,
  end_year: 2022,
  description: 'Created engaging content for various client campaigns and platforms. Developed content strategies and created diverse content types to support marketing objectives. Worked with creative teams to ensure content quality and brand consistency.'
)

ExternalLinkItem.create(
  resume: resume_115,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate115'
)

ExternalLinkItem.create(
  resume: resume_115,
  name: 'Content Portfolio',
  url: 'https://candidate115-content-portfolio.com'
)

ReferenceItem.create(
  resume: resume_115,
  name: 'David Chen',
  position: 'Content Director',
  company: 'Content Creation Studio',
  mobile: '+1 555 0115',
  kind: :job
)

ReferenceItem.create(
  resume: resume_115,
  name: 'Lisa Rodriguez',
  position: 'Creative Director',
  company: 'Creative Content Agency',
  mobile: '+1 555 0115',
  kind: :personal
)

# Candidate 116
candidate_116 = Candidate.new(email: 'candidate_116@simplestresumes.com', password: password)
candidate_116.skip_confirmation!
candidate_116.save

resume_116 = Resume.create(
  candidate_id: candidate_116.id,
  name: 'Sarah Davis',
  email: candidate_116.email,
  mobile: '+1 555 0116',
  location: 'Austin, TX',
  about_me: 'Experienced data analyst with expertise in statistical analysis and business intelligence. I transform data into actionable insights that support strategic decision-making.'
)

EducationItem.create(
  resume_id: resume_116.id,
  name: 'Data Science',
  institute: 'University of Texas',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_116.id,
  name: 'Statistical Analysis Certification',
  institute: 'Coursera',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_116,
  name: 'Data Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_116,
  name: 'Statistical Analysis',
  kind: :primary
)

SkillItem.create(
  resume: resume_116,
  name: 'Business Intelligence',
  kind: :primary
)

SkillItem.create(
  resume: resume_116,
  name: 'Data Visualization',
  kind: :secondary
)

SkillItem.create(
  resume: resume_116,
  name: 'SQL',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_116,
  position: 'Senior Data Analyst',
  company: 'Data Analytics Group',
  location: 'Austin, TX',
  start_month: 6,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led data analysis initiatives that provided critical insights for strategic decision-making, supporting business growth initiatives that increased revenue by 40% and improved operational efficiency by 35%. Conducted comprehensive statistical analysis and developed predictive models that identified trends and opportunities for business optimization. Created data visualizations and reports that effectively communicated complex analytical findings to stakeholders and supported data-driven decision-making.'
)

WorkExperienceItem.create(
  resume: resume_116,
  position: 'Data Analyst',
  company: 'Analytics Solutions Pro',
  location: 'Austin, TX',
  start_month: 1,
  start_year: 2021,
  end_month: 5,
  end_year: 2022,
  description: 'Analyzed business data and conducted statistical analysis to support decision-making processes. Created data visualizations and reports that communicated insights to stakeholders. Supported business intelligence initiatives and data-driven decision-making.'
)

ExternalLinkItem.create(
  resume: resume_116,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate116'
)

ExternalLinkItem.create(
  resume: resume_116,
  name: 'GitHub',
  url: 'https://github.com/candidate116'
)

ReferenceItem.create(
  resume: resume_116,
  name: 'Amanda Rodriguez',
  position: 'Analytics Director',
  company: 'Data Analytics Group',
  mobile: '+1 555 0116',
  kind: :job
)

ReferenceItem.create(
  resume: resume_116,
  name: 'Michael Chen',
  position: 'Senior Analyst',
  company: 'Analytics Solutions Pro',
  mobile: '+1 555 0116',
  kind: :personal
)

# Candidate 117
candidate_117 = Candidate.new(email: 'candidate_117@simplestresumes.com', password: password)
candidate_117.skip_confirmation!
candidate_117.save

resume_117 = Resume.create(
  candidate_id: candidate_117.id,
  name: 'Christopher Brown',
  email: candidate_117.email,
  mobile: '+1 555 0117',
  location: 'Houston, TX',
  about_me: 'Innovative product manager with expertise in agile methodologies and user-centered design. I deliver products that solve real problems and create meaningful user experiences.'
)

EducationItem.create(
  resume_id: resume_117.id,
  name: 'Product Management',
  institute: 'Rice University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_117.id,
  name: 'Agile Scrum Master',
  institute: 'Scrum Alliance',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_117,
  name: 'Product Management',
  kind: :primary
)

SkillItem.create(
  resume: resume_117,
  name: 'Agile Methodologies',
  kind: :primary
)

SkillItem.create(
  resume: resume_117,
  name: 'User-Centered Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_117,
  name: 'Product Strategy',
  kind: :secondary
)

SkillItem.create(
  resume: resume_117,
  name: 'Stakeholder Management',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_117,
  position: 'Senior Product Manager',
  company: 'Product Innovation Corp',
  location: 'Houston, TX',
  start_month: 2,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led product strategy and development for a portfolio of digital products serving over 200,000 users, resulting in 50% increase in user engagement and 40% improvement in customer satisfaction scores. Managed cross-functional product teams using agile methodologies, ensuring timely delivery of high-quality products that met user needs and business objectives. Conducted user research and market analysis to inform product decisions and prioritize feature development.'
)

WorkExperienceItem.create(
  resume: resume_117,
  position: 'Product Manager',
  company: 'Digital Products Solutions',
  location: 'Houston, TX',
  start_month: 7,
  start_year: 2020,
  end_month: 1,
  end_year: 2022,
  description: 'Managed product development lifecycle for multiple digital products, working with development teams to deliver features and improvements. Conducted user research and gathered feedback to inform product decisions and prioritize development efforts. Collaborated with stakeholders to define product requirements and ensure successful product launches.'
)

ExternalLinkItem.create(
  resume: resume_117,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate117'
)

ExternalLinkItem.create(
  resume: resume_117,
  name: 'Product Blog',
  url: 'https://candidate117-product-blog.com'
)

ReferenceItem.create(
  resume: resume_117,
  name: 'Jessica Taylor',
  position: 'VP of Product',
  company: 'Product Innovation Corp',
  mobile: '+1 555 0117',
  kind: :job
)

ReferenceItem.create(
  resume: resume_117,
  name: 'Mark Johnson',
  position: 'Product Director',
  company: 'Digital Products Solutions',
  mobile: '+1 555 0117',
  kind: :personal
)

# Candidate 118
candidate_118 = Candidate.new(email: 'candidate_118@simplestresumes.com', password: password)
candidate_118.skip_confirmation!
candidate_118.save

resume_118 = Resume.create(
  candidate_id: candidate_118.id,
  name: 'Nicole Wilson',
  email: candidate_118.email,
  mobile: '+1 555 0118',
  location: 'San Antonio, TX',
  about_me: 'Strategic business development professional with expertise in market expansion and partnership development. I identify opportunities and build strategic relationships.'
)

EducationItem.create(
  resume_id: resume_118.id,
  name: 'Business Development',
  institute: 'University of Texas at San Antonio',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_118.id,
  name: 'Strategic Partnerships Certification',
  institute: 'Business Development Institute',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_118,
  name: 'Business Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_118,
  name: 'Market Expansion',
  kind: :primary
)

SkillItem.create(
  resume: resume_118,
  name: 'Partnership Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_118,
  name: 'Strategic Planning',
  kind: :secondary
)

SkillItem.create(
  resume: resume_118,
  name: 'Relationship Building',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_118,
  position: 'Senior Business Development Manager',
  company: 'Business Growth Partners',
  location: 'San Antonio, TX',
  start_month: 9,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led business development initiatives that expanded market presence into 8 new territories and established strategic partnerships that generated $20M in additional revenue. Developed and executed market expansion strategies that identified new opportunities and positioned the company for sustainable growth in emerging markets. Built and maintained relationships with key partners, clients, and stakeholders that supported business objectives and created new revenue streams.'
)

WorkExperienceItem.create(
  resume: resume_118,
  position: 'Business Development Manager',
  company: 'Strategic Partnerships Inc',
  location: 'San Antonio, TX',
  start_month: 4,
  start_year: 2021,
  end_month: 8,
  end_year: 2022,
  description: 'Identified new business opportunities and developed strategies for market expansion and growth. Built relationships with potential partners and clients to support business development objectives. Conducted market research and analysis to inform business development strategies.'
)

ExternalLinkItem.create(
  resume: resume_118,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate118'
)

ReferenceItem.create(
  resume: resume_118,
  name: 'David Thompson',
  position: 'Business Development Director',
  company: 'Business Growth Partners',
  mobile: '+1 555 0118',
  kind: :job
)

ReferenceItem.create(
  resume: resume_118,
  name: 'Lisa Anderson',
  position: 'Partnership Manager',
  company: 'Strategic Partnerships Inc',
  mobile: '+1 555 0118',
  kind: :personal
)

# Candidate 119
candidate_119 = Candidate.new(email: 'candidate_119@simplestresumes.com', password: password)
candidate_119.skip_confirmation!
candidate_119.save

resume_119 = Resume.create(
  candidate_id: candidate_119.id,
  name: 'James Anderson',
  email: candidate_119.email,
  mobile: '+1 555 0119',
  location: 'Dallas, TX',
  about_me: 'Creative UX designer with expertise in user research and interface design. I create intuitive user experiences that delight users and drive engagement.'
)

EducationItem.create(
  resume_id: resume_119.id,
  name: 'User Experience Design',
  institute: 'Southern Methodist University',
  start_year: 2018,
  end_year: 2022
)

EducationItem.create(
  resume_id: resume_119.id,
  name: 'UX Research Certification',
  institute: 'Nielsen Norman Group',
  start_year: 2022,
  end_year: 2022
)

SkillItem.create(
  resume: resume_119,
  name: 'UX Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_119,
  name: 'User Research',
  kind: :primary
)

SkillItem.create(
  resume: resume_119,
  name: 'Interface Design',
  kind: :primary
)

SkillItem.create(
  resume: resume_119,
  name: 'Wireframing',
  kind: :secondary
)

SkillItem.create(
  resume: resume_119,
  name: 'Prototyping',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_119,
  position: 'Senior UX Designer',
  company: 'UX Design Studio',
  location: 'Dallas, TX',
  start_month: 11,
  start_year: 2021,
  end_month: 12,
  end_year: 2024,
  description: 'Led UX design initiatives for digital products serving millions of users, resulting in 65% improvement in user satisfaction scores and 45% reduction in user support requests. Conducted comprehensive user research including interviews, surveys, and usability testing to inform design decisions and validate solutions. Developed user personas, journey maps, and design systems that ensured consistent and intuitive user experiences across all product touchpoints.'
)

WorkExperienceItem.create(
  resume: resume_119,
  position: 'UX Designer',
  company: 'Digital Experience Lab',
  location: 'Dallas, TX',
  start_month: 5,
  start_year: 2020,
  end_month: 10,
  end_year: 2021,
  description: 'Designed user interfaces and user experiences for web and mobile applications. Conducted user research and usability testing to inform design decisions. Created wireframes, prototypes, and design specifications for development teams.'
)

ExternalLinkItem.create(
  resume: resume_119,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate119'
)

ExternalLinkItem.create(
  resume: resume_119,
  name: 'Dribbble',
  url: 'https://dribbble.com/candidate119'
)

ReferenceItem.create(
  resume: resume_119,
  name: 'David Kim',
  position: 'UX Director',
  company: 'UX Design Studio',
  mobile: '+1 555 0119',
  kind: :job
)

ReferenceItem.create(
  resume: resume_119,
  name: 'Lisa Rodriguez',
  position: 'Design Manager',
  company: 'Digital Experience Lab',
  mobile: '+1 555 0119',
  kind: :personal
)

# Candidate 120
candidate_120 = Candidate.new(email: 'candidate_120@simplestresumes.com', password: password)
candidate_120.skip_confirmation!
candidate_120.save

resume_120 = Resume.create(
  candidate_id: candidate_120.id,
  name: 'Andrew Johnson',
  email: candidate_120.email,
  mobile: '+1 555 0120',
  location: 'Fort Worth, TX',
  about_me: 'Strategic business consultant with expertise in process improvement and organizational development. I help organizations optimize performance and achieve growth objectives.'
)

EducationItem.create(
  resume_id: resume_120.id,
  name: 'Business Administration',
  institute: 'Texas Christian University',
  start_year: 2017,
  end_year: 2021
)

EducationItem.create(
  resume_id: resume_120.id,
  name: 'Management Consulting Certification',
  institute: 'McKinsey',
  start_year: 2021,
  end_year: 2021
)

SkillItem.create(
  resume: resume_120,
  name: 'Business Consulting',
  kind: :primary
)

SkillItem.create(
  resume: resume_120,
  name: 'Process Improvement',
  kind: :primary
)

SkillItem.create(
  resume: resume_120,
  name: 'Organizational Development',
  kind: :primary
)

SkillItem.create(
  resume: resume_120,
  name: 'Change Management',
  kind: :secondary
)

SkillItem.create(
  resume: resume_120,
  name: 'Performance Optimization',
  kind: :secondary
)

WorkExperienceItem.create(
  resume: resume_120,
  position: 'Senior Business Consultant',
  company: 'Strategic Consulting Group',
  location: 'Fort Worth, TX',
  start_month: 7,
  start_year: 2022,
  end_month: 12,
  end_year: 2024,
  description: 'Led strategic consulting engagements for Fortune 500 companies, delivering solutions that improved operational efficiency by 60% and increased profitability by 45%. Developed comprehensive business strategies and organizational development plans that supported long-term growth objectives. Managed client relationships and project teams, ensuring successful delivery of consulting services and measurable business outcomes.'
)

WorkExperienceItem.create(
  resume: resume_120,
  position: 'Business Consultant',
  company: 'Management Solutions Pro',
  location: 'Fort Worth, TX',
  start_month: 1,
  start_year: 2021,
  end_month: 6,
  end_year: 2022,
  description: 'Provided business consulting services to various client organizations, analyzing business processes and developing improvement recommendations. Conducted organizational assessments and supported strategic planning initiatives. Worked with client teams to implement recommended changes and measure outcomes.'
)

ExternalLinkItem.create(
  resume: resume_120,
  name: 'LinkedIn',
  url: 'https://www.linkedin.com/in/candidate120'
)

ReferenceItem.create(
  resume: resume_120,
  name: 'Sarah Davis',
  position: 'Consulting Director',
  company: 'Strategic Consulting Group',
  mobile: '+1 555 0120',
  kind: :job
)

ReferenceItem.create(
  resume: resume_120,
  name: 'David Brown',
  position: 'Senior Consultant',
  company: 'Management Solutions Pro',
  mobile: '+1 555 0120',
  kind: :personal
)

# ---------- Postulations ----------
# Candidate 1
Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_15,
  status: :rejected
)

Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_30,
  status: :approved
)

Postulation.create(
  candidate: candidate_1,
  job_posting: job_posting_35,
  status: :pending
)

# Candidate 2
Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_9,
  status: :approved
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_10,
  status: :rejected
)

Postulation.create(
  candidate: candidate_2,
  job_posting: job_posting_16,
  status: :pending
)

# Candidate 3
Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_13,
  status: :approved
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_20,
  status: :approved
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_9,
  status: :rejected
)

Postulation.create(
  candidate: candidate_3,
  job_posting: job_posting_15,
  status: :pending
)

# Candidate 4
Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_4,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 5
Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_5,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 6
Postulation.create(
  candidate: candidate_6,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_6,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_6,
  job_posting: job_posting_16,
  status: :rejected
)

Postulation.create(
  candidate: candidate_6,
  job_posting: job_posting_12,
  status: :pending
)

# Candidate 7
Postulation.create(
  candidate: candidate_7,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_7,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_7,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_7,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 8
Postulation.create(
  candidate: candidate_8,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_8,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_8,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_8,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 9
Postulation.create(
  candidate: candidate_9,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_9,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_9,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_9,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 10
Postulation.create(
  candidate: candidate_10,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_10,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_10,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_10,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 11
Postulation.create(
  candidate: candidate_11,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_11,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_11,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_11,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 12
Postulation.create(
  candidate: candidate_12,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_12,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_12,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_12,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 13
Postulation.create(
  candidate: candidate_13,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_13,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_13,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_13,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 14
Postulation.create(
  candidate: candidate_14,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_14,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_14,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_14,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 15
Postulation.create(
  candidate: candidate_15,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_15,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_15,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_15,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 16
Postulation.create(
  candidate: candidate_16,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_16,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_16,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_16,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 17
Postulation.create(
  candidate: candidate_17,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_17,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_17,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_17,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 18
Postulation.create(
  candidate: candidate_18,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_18,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_18,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_18,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 19
Postulation.create(
  candidate: candidate_19,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_19,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_19,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_19,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 20
Postulation.create(
  candidate: candidate_20,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_20,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_20,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_20,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 21
Postulation.create(
  candidate: candidate_21,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_21,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_21,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_21,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 22
Postulation.create(
  candidate: candidate_22,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_22,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_22,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_22,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 23
Postulation.create(
  candidate: candidate_23,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_23,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_23,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_23,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 24
Postulation.create(
  candidate: candidate_24,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_24,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_24,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_24,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 25
Postulation.create(
  candidate: candidate_25,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_25,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_25,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_25,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 26
Postulation.create(
  candidate: candidate_26,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_26,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_26,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_26,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 27
Postulation.create(
  candidate: candidate_27,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_27,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_27,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_27,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 28
Postulation.create(
  candidate: candidate_28,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_28,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_28,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_28,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 29
Postulation.create(
  candidate: candidate_29,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_29,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_29,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_29,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 30
Postulation.create(
  candidate: candidate_30,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_30,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_30,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_30,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 31
Postulation.create(
  candidate: candidate_31,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_31,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_31,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_31,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 32
Postulation.create(
  candidate: candidate_32,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_32,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_32,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_32,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 33
Postulation.create(
  candidate: candidate_33,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_33,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_33,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_33,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 34
Postulation.create(
  candidate: candidate_34,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_34,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_34,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_34,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 35
Postulation.create(
  candidate: candidate_35,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_35,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_35,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_35,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 36
Postulation.create(
  candidate: candidate_36,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_36,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_36,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_36,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 37
Postulation.create(
  candidate: candidate_37,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_37,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_37,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_37,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 38
Postulation.create(
  candidate: candidate_38,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_38,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_38,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_38,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 39
Postulation.create(
  candidate: candidate_39,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_39,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_39,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_39,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 40
Postulation.create(
  candidate: candidate_40,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_40,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_40,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_40,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 41
Postulation.create(
  candidate: candidate_41,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_41,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_41,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_41,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 42
Postulation.create(
  candidate: candidate_42,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_42,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_42,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_42,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 43
Postulation.create(
  candidate: candidate_43,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_43,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_43,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_43,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 44
Postulation.create(
  candidate: candidate_44,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_44,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_44,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_44,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 45
Postulation.create(
  candidate: candidate_45,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_45,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_45,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_45,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 46
Postulation.create(
  candidate: candidate_46,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_46,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_46,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_46,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 47
Postulation.create(
  candidate: candidate_47,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_47,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_47,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_47,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 48
Postulation.create(
  candidate: candidate_48,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_48,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_48,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_48,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 49
Postulation.create(
  candidate: candidate_49,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_49,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_49,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_49,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 50
Postulation.create(
  candidate: candidate_50,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_50,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_50,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_50,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 51
Postulation.create(
  candidate: candidate_51,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_51,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_51,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_51,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 52
Postulation.create(
  candidate: candidate_52,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_52,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_52,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_52,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 53
Postulation.create(
  candidate: candidate_53,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_53,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_53,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_53,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 54
Postulation.create(
  candidate: candidate_54,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_54,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_54,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_54,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 55
Postulation.create(
  candidate: candidate_55,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_55,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_55,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_55,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 56
Postulation.create(
  candidate: candidate_56,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_56,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_56,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_56,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 57
Postulation.create(
  candidate: candidate_57,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_57,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_57,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_57,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 58
Postulation.create(
  candidate: candidate_58,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_58,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_58,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_58,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 59
Postulation.create(
  candidate: candidate_59,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_59,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_59,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_59,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 60
Postulation.create(
  candidate: candidate_60,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_60,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_60,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_60,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 61
Postulation.create(
  candidate: candidate_61,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_61,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_61,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_61,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 62
Postulation.create(
  candidate: candidate_62,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_62,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_62,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_62,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 63
Postulation.create(
  candidate: candidate_63,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_63,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_63,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_63,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 64
Postulation.create(
  candidate: candidate_64,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_64,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_64,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_64,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 65
Postulation.create(
  candidate: candidate_65,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_65,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_65,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_65,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 66
Postulation.create(
  candidate: candidate_66,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_66,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_66,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_66,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 67
Postulation.create(
  candidate: candidate_67,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_67,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_67,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_67,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 68
Postulation.create(
  candidate: candidate_68,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_68,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_68,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_68,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 69
Postulation.create(
  candidate: candidate_69,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_69,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_69,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_69,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 70
Postulation.create(
  candidate: candidate_70,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_70,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_70,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_70,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 71
Postulation.create(
  candidate: candidate_71,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_71,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_71,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_71,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 72
Postulation.create(
  candidate: candidate_72,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_72,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_72,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_72,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 73
Postulation.create(
  candidate: candidate_73,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_73,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_73,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_73,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 74
Postulation.create(
  candidate: candidate_74,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_74,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_74,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_74,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 75
Postulation.create(
  candidate: candidate_75,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_75,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_75,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_75,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 76
Postulation.create(
  candidate: candidate_76,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_76,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_76,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_76,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 77
Postulation.create(
  candidate: candidate_77,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_77,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_77,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_77,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 78
Postulation.create(
  candidate: candidate_78,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_78,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_78,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_78,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 79
Postulation.create(
  candidate: candidate_79,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_79,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_79,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_79,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 80
Postulation.create(
  candidate: candidate_80,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_80,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_80,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_80,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 81
Postulation.create(
  candidate: candidate_81,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_81,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_81,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_81,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 82
Postulation.create(
  candidate: candidate_82,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_82,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_82,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_82,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 83
Postulation.create(
  candidate: candidate_83,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_83,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_83,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_83,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 84
Postulation.create(
  candidate: candidate_84,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_84,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_84,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_84,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 85
Postulation.create(
  candidate: candidate_85,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_85,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_85,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_85,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 86
Postulation.create(
  candidate: candidate_86,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_86,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_86,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_86,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 87
Postulation.create(
  candidate: candidate_87,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_87,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_87,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_87,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 88
Postulation.create(
  candidate: candidate_88,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_88,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_88,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_88,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 89
Postulation.create(
  candidate: candidate_89,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_89,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_89,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_89,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 90
Postulation.create(
  candidate: candidate_90,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_90,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_90,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_90,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 91
Postulation.create(
  candidate: candidate_91,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_91,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_91,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_91,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 92
Postulation.create(
  candidate: candidate_92,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_92,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_92,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_92,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 93
Postulation.create(
  candidate: candidate_93,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_93,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_93,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_93,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 94
Postulation.create(
  candidate: candidate_94,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_94,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_94,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_94,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 95
Postulation.create(
  candidate: candidate_95,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_95,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_95,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_95,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 96
Postulation.create(
  candidate: candidate_96,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_96,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_96,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_96,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 97
Postulation.create(
  candidate: candidate_97,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_97,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_97,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_97,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 98
Postulation.create(
  candidate: candidate_98,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_98,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_98,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_98,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 99
Postulation.create(
  candidate: candidate_99,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_99,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_99,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_99,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 100
Postulation.create(
  candidate: candidate_100,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_100,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_100,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_100,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 101
Postulation.create(
  candidate: candidate_101,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_101,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_101,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_101,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 102
Postulation.create(
  candidate: candidate_102,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_102,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_102,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_102,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 103
Postulation.create(
  candidate: candidate_103,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_103,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_103,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_103,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 104
Postulation.create(
  candidate: candidate_104,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_104,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_104,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_104,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 105
Postulation.create(
  candidate: candidate_105,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_105,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_105,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_105,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 106
Postulation.create(
  candidate: candidate_106,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_106,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_106,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_106,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 107
Postulation.create(
  candidate: candidate_107,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_107,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_107,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_107,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 108
Postulation.create(
  candidate: candidate_108,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_108,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_108,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_108,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 109
Postulation.create(
  candidate: candidate_109,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_109,
  job_posting: job_posting_10,
  status: :approved
)

Postulation.create(
  candidate: candidate_109,
  job_posting: job_posting_17,
  status: :rejected
)

Postulation.create(
  candidate: candidate_109,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 110
Postulation.create(
  candidate: candidate_110,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_110,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_110,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_110,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 111
Postulation.create(
  candidate: candidate_111,
  job_posting: job_posting_14,
  status: :approved
)

Postulation.create(
  candidate: candidate_111,
  job_posting: job_posting_19,
  status: :approved
)

Postulation.create(
  candidate: candidate_111,
  job_posting: job_posting_7,
  status: :rejected
)

Postulation.create(
  candidate: candidate_111,
  job_posting: job_posting_20,
  status: :pending
)

# Candidate 112
Postulation.create(
  candidate: candidate_112,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_112,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_112,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_112,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 113
Postulation.create(
  candidate: candidate_113,
  job_posting: job_posting_1,
  status: :approved
)

Postulation.create(
  candidate: candidate_113,
  job_posting: job_posting_9,
  status: :approved
)

Postulation.create(
  candidate: candidate_113,
  job_posting: job_posting_16,
  status: :rejected
)

Postulation.create(
  candidate: candidate_113,
  job_posting: job_posting_21,
  status: :pending
)

# Candidate 114
Postulation.create(
  candidate: candidate_114,
  job_posting: job_posting_14,
  status: :approved
)

Postulation.create(
  candidate: candidate_114,
  job_posting: job_posting_19,
  status: :approved
)

Postulation.create(
  candidate: candidate_114,
  job_posting: job_posting_7,
  status: :rejected
)

Postulation.create(
  candidate: candidate_114,
  job_posting: job_posting_20,
  status: :pending
)

# Candidate 115
Postulation.create(
  candidate: candidate_115,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_115,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_115,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_115,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 116
Postulation.create(
  candidate: candidate_116,
  job_posting: job_posting_2,
  status: :approved
)

Postulation.create(
  candidate: candidate_116,
  job_posting: job_posting_17,
  status: :approved
)

Postulation.create(
  candidate: candidate_116,
  job_posting: job_posting_21,
  status: :rejected
)

Postulation.create(
  candidate: candidate_116,
  job_posting: job_posting_14,
  status: :pending
)

# Candidate 117
Postulation.create(
  candidate: candidate_117,
  job_posting: job_posting_3,
  status: :approved
)

Postulation.create(
  candidate: candidate_117,
  job_posting: job_posting_19,
  status: :approved
)

Postulation.create(
  candidate: candidate_117,
  job_posting: job_posting_7,
  status: :rejected
)

Postulation.create(
  candidate: candidate_117,
  job_posting: job_posting_20,
  status: :pending
)

# Candidate 118
Postulation.create(
  candidate: candidate_118,
  job_posting: job_posting_4,
  status: :approved
)

Postulation.create(
  candidate: candidate_118,
  job_posting: job_posting_15,
  status: :approved
)

Postulation.create(
  candidate: candidate_118,
  job_posting: job_posting_19,
  status: :rejected
)

Postulation.create(
  candidate: candidate_118,
  job_posting: job_posting_7,
  status: :pending
)

# Candidate 119
Postulation.create(
  candidate: candidate_119,
  job_posting: job_posting_13,
  status: :approved
)

Postulation.create(
  candidate: candidate_119,
  job_posting: job_posting_20,
  status: :approved
)

Postulation.create(
  candidate: candidate_119,
  job_posting: job_posting_9,
  status: :rejected
)

Postulation.create(
  candidate: candidate_119,
  job_posting: job_posting_15,
  status: :pending
)

# Candidate 120
Postulation.create(
  candidate: candidate_120,
  job_posting: job_posting_14,
  status: :approved
)

Postulation.create(
  candidate: candidate_120,
  job_posting: job_posting_19,
  status: :approved
)

Postulation.create(
  candidate: candidate_120,
  job_posting: job_posting_7,
  status: :rejected
)

Postulation.create(
  candidate: candidate_120,
  job_posting: job_posting_20,
  status: :pending
)

Candidate.set_callback(:create, :after, :create_stripe_customer)
