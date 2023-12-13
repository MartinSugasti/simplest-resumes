/* eslint-disable max-len */
import React from 'react';
import {
  Document,
  Page,
  Text,
  View,
  Svg,
  Path,
  StyleSheet,
  Font
} from '@react-pdf/renderer';

Font.register({
  family: 'Open Sans',
  fonts: [
    { src: 'https://cdn.jsdelivr.net/npm/open-sans-all@0.1.3/fonts/open-sans-regular.ttf' },
    { src: 'https://cdn.jsdelivr.net/npm/open-sans-all@0.1.3/fonts/open-sans-600.ttf', fontWeight: 'semibold' },
    { src: 'https://cdn.jsdelivr.net/npm/open-sans-all@0.1.3/fonts/open-sans-700.ttf', fontWeight: 'bold' }
  ]
});

Font.register({
  family: 'Roboto',
  fonts: [
    { src: 'https://cdn.jsdelivr.net/npm/roboto-font@0.1.0/fonts/Roboto/roboto-regular-webfont.ttf' },
    { src: 'https://cdn.jsdelivr.net/npm/roboto-font@0.1.0/fonts/Roboto/roboto-medium-webfont.ttf', fontWeight: 'semibold' },
    { src: 'https://cdn.jsdelivr.net/npm/roboto-font@0.1.0/fonts/Roboto/roboto-bold-webfont.ttf', fontWeight: 'bold' }
  ]
});

// Create styles
const styles = StyleSheet.create({
  page: {
    paddingHorizontal: '10mm',
    paddingVertical: '2mm',
    fontFamily: 'Roboto',
    fontSize: '3mm'
  },

  title: {
    textAlign: 'center',
    fontWeight: 'bold',
    fontSize: '6mm',
    marginBottom: '3mm'
  },

  sectionTitle: {
    fontSize: '4mm',
    fontWeight: 'semibold',
    marginTop: '3mm',
    marginBottom: '0.5mm'
  },

  personalDetails: {
    display: 'flex',
    flexDirection: 'row',

    detail: {
      width: '33.3%',
      textAlign: 'center',

      iconWrapper: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'center',
        marginBottom: '0.5mm'
      }
    }
  },

  education: {
    item: {
      display: 'flex',
      flexDirection: 'row',
      marginBottom: '1mm',

      name: {
        width: '55%',
        fontWeight: 'semibold'
      },

      institute: {
        width: '40%'
      },

      dates: {
        width: '15%',
        textAlign: 'right'
      }
    }
  },

  workExperience: {
    item: {
      marginBottom: '1.5mm',

      line: {
        display: 'flex',
        flexDirection: 'row',
        fontWeight: 'semibold',
        marginBottom: '1mm',

        leftText: {
          width: '50%'
        },

        rightText: {
          textAlign: 'right',
          width: '50%'
        }
      }
    }
  },

  skills: {
    primary: {
      fontWeight: 'semibold',
      marginBottom: '1mm'
    }
  },

  externalLinks: {
    item: {
      display: 'flex',
      flexDirection: 'row',
      marginBottom: '1mm',

      site: {
        fontWeight: 'semibold'
      }
    }
  },

  references: {
    display: 'flex',
    flexDirection: 'row',

    personal: {
      width: '50%',
      marginRight: '20mm'
    },

    job: {
      width: '50%'
    },

    item: {
      marginBottom: '1.5mm',

      line: {
        display: 'flex',
        flexDirection: 'row',

        firstLine: {
          fontWeight: 'semibold',
          marginBottom: '1mm'
        },

        rightText: {
          width: '50%'
        },

        leftText: {
          textAlign: 'right',
          width: '50%'
        }
      }
    }
  }
});

// Create Document Component
const Pdf = () => (
  <Document>
    <Page size="LETTER" style={styles.page}>
      <View style={styles.title}>
        <Text>MARTÍN SUGASTI</Text>
      </View>

      <View style={styles.personalDetails}>
        <View style={styles.personalDetails.detail}>
          <View style={styles.personalDetails.detail.iconWrapper}>
            <Svg width="12" height="12" viewBox="0 0 16 16" fill="black">
              <Path
                d="M2 2a2 2 0 0 0-2 2v8.01A2 2 0 0 0 2 14h5.5a.5.5 0 0 0 0-1H2a1 1 0 0 1-.966-.741l5.64-3.471L8 9.583l7-4.2V8.5a.5.5 0 0 0 1 0V4a2 2 0 0 0-2-2zm3.708 6.208L1 11.105V5.383zM1 4.217V4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v.217l-7 4.2z"
              />
              <Path
                d="M14.247 14.269c1.01 0 1.587-.857 1.587-2.025v-.21C15.834 10.43 14.64 9 12.52 9h-.035C10.42 9 9 10.36 9 12.432v.214C9 14.82 10.438 16 12.358 16h.044c.594 0 1.018-.074 1.237-.175v-.73c-.245.11-.673.18-1.18.18h-.044c-1.334 0-2.571-.788-2.571-2.655v-.157c0-1.657 1.058-2.724 2.64-2.724h.04c1.535 0 2.484 1.05 2.484 2.326v.118c0 .975-.324 1.39-.639 1.39-.232 0-.41-.148-.41-.42v-2.19h-.906v.569h-.03c-.084-.298-.368-.63-.954-.63-.778 0-1.259.555-1.259 1.4v.528c0 .892.49 1.434 1.26 1.434.471 0 .896-.227 1.014-.643h.043c.118.42.617.648 1.12.648Zm-2.453-1.588v-.227c0-.546.227-.791.573-.791.297 0 .572.192.572.708v.367c0 .573-.253.744-.564.744-.354 0-.581-.215-.581-.8Z"
              />
            </Svg>
          </View>

          <Text>martinsugasti@gmail.com</Text>
        </View>

        <View style={styles.personalDetails.detail}>
          <View style={styles.personalDetails.detail.iconWrapper}>
            <Svg width="12" height="12" viewBox="0 0 16 16" fill="black">
              <Path
                d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"
              />
              <Path
                d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2"
              />
            </Svg>
          </View>

          <Text>+34 696 924 288</Text>
        </View>

        <View style={styles.personalDetails.detail}>
          <View style={styles.personalDetails.detail.iconWrapper}>
            <Svg width="12" height="12" viewBox="0 0 16 16" fill="black">
              <Path
                d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A31.493 31.493 0 0 1 8 14.58a31.481 31.481 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10"
              />
              <Path
                d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4m0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6"
              />
            </Svg>
          </View>

          <Text>Barcelona, Spain</Text>
        </View>
      </View>

      <View>
        <Text style={styles.sectionTitle}>ABOUT ME</Text>

        <Text>
          I am an industrial engineer, with experience working in supply chain. However, due to vocational preferences, I decided on a change in my professional profile and started studying Software Engineering and working as a full-stack developer. As a personal challenge and in search of new experiences, I moved to Barcelona in August 2021 with my partner.
        </Text>
      </View>

      <View>
        <Text style={styles.sectionTitle}>EDUCATION</Text>

        <View>
          <View style={styles.education.item}>
            <Text style={styles.education.item.name}>Software Engineering (4th grade)</Text>
            <Text style={styles.education.item.institute}>Engineering Faculty, UDELAR</Text>
            <Text style={styles.education.item.dates}>2019 - Present</Text>
          </View>

          <View style={styles.education.item}>
            <Text style={styles.education.item.name}>Graduated in Industrial and Mechanical Engineering</Text>
            <Text style={styles.education.item.institute}>Engineering Faculty, UDELAR</Text>
            <Text style={styles.education.item.dates}>2009 - 2015</Text>
          </View>

          <View style={styles.education.item}>
            <Text style={styles.education.item.name}>First Certificate in English</Text>
            <Text style={styles.education.item.institute}>University of Cambridge</Text>
            <Text style={styles.education.item.dates}>2000 - 2008</Text>
          </View>
        </View>
      </View>

      <View>
        <Text style={styles.sectionTitle}>PROFESSIONAL EXPERIENCE</Text>

        <View>
          <View style={styles.workExperience.item}>
            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Vairix</Text>
              <Text style={styles.workExperience.item.line.rightText}>2/2021 - Present</Text>
            </View>

            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Full Stack Developer</Text>
              <Text style={styles.workExperience.item.line.rightText}>Montevideo, Uruguay</Text>
            </View>

            <Text>
              Worked as a full-stack developer using Ruby on Rails framework gaining experience in, within others, authentication and authorization systems, background jobs, scheduled tasks, ajax requests, third-party APIs integration, internationalization, mailers, data visualization, etc. Alongside RoR, I also gained experience with other languages, libraries and development tools such as HTML, CSS, JS, bootstrap, git, GitHub, SQL and Heroku. During this time, I have dealt with a variety of clients, spanning from small local companies to large multinational corporations using Agile/Scrum development techniques, staying in touch with clients daily, and reaching mutual agreements on ideas and next steps.
            </Text>
          </View>

          <View style={styles.workExperience.item}>
            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>EagerWorks SRL</Text>
              <Text style={styles.workExperience.item.line.rightText}>9/2019 - 2/2021</Text>
            </View>

            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Full Stack Developer</Text>
              <Text style={styles.workExperience.item.line.rightText}>Montevideo, Uruguay</Text>
            </View>

            <Text>
              Worked as a full-stack developer using Ruby on Rails framework gaining experience in, within others, authentication and authorization systems, background jobs, scheduled tasks, ajax requests, third-party APIs integration, internationalization, mailers, data visualization, etc. Alongside RoR, I also gained experience with other languages, libraries and development tools such as HTML, CSS, JS, bootstrap, git, GitHub, SQL and Heroku. During this time, I have dealt with a variety of clients, spanning from small local companies to large multinational corporations using Agile/Scrum development techniques, staying in touch with clients daily, and reaching mutual agreements on ideas and next steps.
            </Text>
          </View>

          <View style={styles.workExperience.item}>
            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Montevideo Refrescos SRL</Text>
              <Text style={styles.workExperience.item.line.rightText}>4/2017 - 9/2019</Text>
            </View>

            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Maintenance Analyst</Text>
              <Text style={styles.workExperience.item.line.rightText}>Montevideo, Uruguay</Text>
            </View>

            <Text>
              Planned preventive and corrective maintenance for the Coca-Cola products bottling company in Uruguay. Executed the maintenance management migration in SAP when the company ownership changed from The Coca-Cola Company to FEMSA. At this point, approximately 1,800 maintenance plans were redesigned.
            </Text>
          </View>

          <View style={styles.workExperience.item}>
            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Yazaki Uruguay SA</Text>
              <Text style={styles.workExperience.item.line.rightText}>5/2015 - 12/2016</Text>
            </View>

            <View style={styles.workExperience.item.line}>
              <Text style={styles.workExperience.item.line.leftText}>Production Coordinator </Text>
              <Text style={styles.workExperience.item.line.rightText}>Las Piedras, Uruguay</Text>
            </View>

            <Text>
              Supervised production plan on a daily basis, coordinating activities with 3 production supervisors. Led a team of 200 plant operators with 4 plant supervisors direct reports and negotiated with labor unions
            </Text>
          </View>
        </View>
      </View>

      <View>
        <Text style={styles.sectionTitle}>SKILLS</Text>

        <Text style={styles.skills.primary}>Ruby On Rails  -  React  -  Scrum</Text>

        <Text>HTML  -  CSS  -  JS  -  SQL  -  Git  -  Cucumber</Text>
      </View>

      <View>
        <Text style={styles.sectionTitle}>EXTERNAL LINKS</Text>

        <View style={styles.externalLinks.item}>
          <Text style={styles.externalLinks.item.site}>
            LinkedIn
            {'  '}
          </Text>
          <Text>
            -
          </Text>
          <Text>
            {'  '}
            https://www.linkedin.com/in/martin-sugasti-ab2aa391/
          </Text>
        </View>

        <View style={styles.externalLinks.item}>
          <Text style={styles.externalLinks.item.site}>
            Github
            {'  '}
          </Text>
          <Text>
            -
          </Text>
          <Text>
            {'  '}
            https://github.com/MartinSugasti
          </Text>
        </View>
      </View>

      <View style={styles.references}>
        <View style={styles.references.personal}>
          <Text style={styles.sectionTitle}>PERSONAL REFERENCES</Text>

          <View style={styles.references.item}>
            <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
              <Text style={styles.references.item.line.rightText}>
                Eng. Guillermo Sugasti
              </Text>

              <Text style={styles.references.item.line.leftText}>
                +1 786 451 7990
              </Text>
            </View>

            <View style={styles.references.item.line}>
              <Text style={styles.references.item.line.rightText}>
                YouTube
              </Text>

              <Text style={styles.references.item.line.leftText}>
                Financial Analyst Specialist
              </Text>
            </View>
          </View>

          <View style={styles.references.item}>
            <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
              <Text style={styles.references.item.line.rightText}>
                Eng. Agustín Prado
              </Text>

              <Text style={styles.references.item.line.leftText}>
                +34 662 08 72 35
              </Text>
            </View>

            <View style={styles.references.item.line}>
              <Text style={styles.references.item.line.rightText}>
                Kodea Software
              </Text>

              <Text style={styles.references.item.line.leftText}>
                CEO
              </Text>
            </View>
          </View>

          <View style={styles.references.item}>
            <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
              <Text style={styles.references.item.line.rightText}>
                Acct. Juan Martin Echeguia
              </Text>

              <Text style={styles.references.item.line.leftText}>
                +34 662 087 228
              </Text>
            </View>

            <View style={styles.references.item.line}>
              <Text style={styles.references.item.line.rightText}>
                Kodea Software
              </Text>

              <Text style={styles.references.item.line.leftText}>
                CTO
              </Text>
            </View>
          </View>
        </View>

        <View style={styles.references.job}>
          <Text style={styles.sectionTitle}>JOB REFERENCES</Text>

          <View style={styles.references.item}>
            <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
              <Text style={styles.references.item.line.rightText}>
                Ignacio Grondona
              </Text>

              <Text style={styles.references.item.line.leftText}>
                +598 98 554 624
              </Text>
            </View>

            <View style={styles.references.item.line}>
              <Text style={styles.references.item.line.rightText}>
                Eagerworks srl
              </Text>

              <Text style={styles.references.item.line.leftText}>
                Technical Leader
              </Text>
            </View>
          </View>

          <View style={styles.references.item}>
            <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
              <Text style={styles.references.item.line.rightText}>
                Eng. Santiago Bertinat
              </Text>

              <Text style={styles.references.item.line.leftText}>
                +598 94 572 567
              </Text>
            </View>

            <View style={styles.references.item.line}>
              <Text style={styles.references.item.line.rightText}>
                Eagerworks srl
              </Text>

              <Text style={styles.references.item.line.leftText}>
                CEO
              </Text>
            </View>
          </View>

          <View style={styles.references.item}>
            <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
              <Text style={styles.references.item.line.rightText}>
                Eng. Jimena Vanoli
              </Text>

              <Text style={styles.references.item.line.leftText}>
                +598 99 459 100
              </Text>
            </View>

            <View style={styles.references.item.line}>
              <Text style={styles.references.item.line.rightText}>
                Montevideo Refrescos SRL
              </Text>

              <Text style={styles.references.item.line.leftText}>
                Maintenance Manager
              </Text>
            </View>
          </View>
        </View>
      </View>
    </Page>
  </Document>
);

export default Pdf;
