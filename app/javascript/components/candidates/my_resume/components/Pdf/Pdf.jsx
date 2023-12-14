import React from 'react';
import PropTypes from 'prop-types';
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
import { useTranslation } from 'react-i18next';

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
    {
      src: 'https://cdn.jsdelivr.net/npm/roboto-font@0.1.0/fonts/Roboto/roboto-medium-webfont.ttf',
      fontWeight: 'semibold'
    },
    { src: 'https://cdn.jsdelivr.net/npm/roboto-font@0.1.0/fonts/Roboto/roboto-bold-webfont.ttf', fontWeight: 'bold' }
  ]
});

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
    justifyContent: 'center',

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
    line: {
      display: 'flex',
      flexDirection: 'row',

      primary: {
        fontWeight: 'semibold',
        marginBottom: '1mm'
      }
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

const Pdf = ({ resume }) => {
  const { t } = useTranslation();

  return (
    <Document>
      <Page size="LETTER" style={styles.page}>
        <View style={styles.title}>
          <Text>{resume?.name?.toUpperCase() || t('candidates.my_resume.show.pdf_title').toUpperCase()}</Text>
        </View>

        {(resume?.email || resume?.mobile || resume?.location) ? (
          <View style={styles.personalDetails}>
            {resume?.email ? (
              <View style={styles.personalDetails.detail}>
                <View style={styles.personalDetails.detail.iconWrapper}>
                  <Svg width="12" height="12" viewBox="0 0 16 16" fill="black">
                    <Path
                      /* eslint-disable-next-line max-len */
                      d="M2 2a2 2 0 0 0-2 2v8.01A2 2 0 0 0 2 14h5.5a.5.5 0 0 0 0-1H2a1 1 0 0 1-.966-.741l5.64-3.471L8 9.583l7-4.2V8.5a.5.5 0 0 0 1 0V4a2 2 0 0 0-2-2zm3.708 6.208L1 11.105V5.383zM1 4.217V4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v.217l-7 4.2z"
                    />
                    <Path
                      /* eslint-disable-next-line max-len */
                      d="M14.247 14.269c1.01 0 1.587-.857 1.587-2.025v-.21C15.834 10.43 14.64 9 12.52 9h-.035C10.42 9 9 10.36 9 12.432v.214C9 14.82 10.438 16 12.358 16h.044c.594 0 1.018-.074 1.237-.175v-.73c-.245.11-.673.18-1.18.18h-.044c-1.334 0-2.571-.788-2.571-2.655v-.157c0-1.657 1.058-2.724 2.64-2.724h.04c1.535 0 2.484 1.05 2.484 2.326v.118c0 .975-.324 1.39-.639 1.39-.232 0-.41-.148-.41-.42v-2.19h-.906v.569h-.03c-.084-.298-.368-.63-.954-.63-.778 0-1.259.555-1.259 1.4v.528c0 .892.49 1.434 1.26 1.434.471 0 .896-.227 1.014-.643h.043c.118.42.617.648 1.12.648Zm-2.453-1.588v-.227c0-.546.227-.791.573-.791.297 0 .572.192.572.708v.367c0 .573-.253.744-.564.744-.354 0-.581-.215-.581-.8Z"
                    />
                  </Svg>
                </View>

                <Text>{resume.email}</Text>
              </View>
            ) : null}

            {resume?.mobile ? (
              <View style={styles.personalDetails.detail}>
                <View style={styles.personalDetails.detail.iconWrapper}>
                  <Svg width="12" height="12" viewBox="0 0 16 16" fill="black">
                    <Path
                      /* eslint-disable-next-line max-len */
                      d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"
                    />
                    <Path
                      d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2"
                    />
                  </Svg>
                </View>

                <Text>{resume.mobile}</Text>
              </View>
            ) : null}

            {resume?.location ? (
              <View style={styles.personalDetails.detail}>
                <View style={styles.personalDetails.detail.iconWrapper}>
                  <Svg width="12" height="12" viewBox="0 0 16 16" fill="black">
                    <Path
                      /* eslint-disable-next-line max-len */
                      d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A31.493 31.493 0 0 1 8 14.58a31.481 31.481 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10"
                    />
                    <Path
                      d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4m0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6"
                    />
                  </Svg>
                </View>

                <Text>{resume.location}</Text>
              </View>
            ) : null}
          </View>
        ) : null}

        {resume?.about_me ? (
          <View>
            <Text style={styles.sectionTitle}>{t('candidates.my_resume.show.about_me').toUpperCase()}</Text>

            <Text>{resume.about_me}</Text>
          </View>
        ) : null}

        {resume?.education_items?.length > 0 ? (
          <View>
            <Text style={styles.sectionTitle}>{t('candidates.my_resume.show.education').toUpperCase()}</Text>

            <View>
              {resume.education_items.map((item) => (
                <View key={item.id} style={styles.education.item}>
                  <Text style={styles.education.item.name}>{item.name}</Text>
                  <Text style={styles.education.item.institute}>{item.institute}</Text>
                  <Text style={styles.education.item.dates}>
                    {item.start_year}
                    {' - '}
                    {item.end_year ? item.end_year : t('candidates.my_resume.show.present')}
                  </Text>
                </View>
              ))}
            </View>
          </View>
        ) : null}

        {resume?.work_experience_items?.length > 0 ? (
          <View>
            <Text style={styles.sectionTitle}>{t('candidates.my_resume.show.work_experience').toUpperCase()}</Text>

            <View>
              {resume.work_experience_items.map((item) => (
                <View key={item.id} style={styles.workExperience.item}>
                  <View style={styles.workExperience.item.line}>
                    <Text style={styles.workExperience.item.line.leftText}>{item.company}</Text>
                    <Text style={styles.workExperience.item.line.rightText}>
                      {`${item.start_month}/${item.start_year}`}
                      {' - '}
                      {item.end_year ? `${item.end_month}/${item.end_year}` : t('candidates.my_resume.show.present')}
                    </Text>
                  </View>

                  <View style={styles.workExperience.item.line}>
                    <Text style={styles.workExperience.item.line.leftText}>{item.position}</Text>
                    <Text style={styles.workExperience.item.line.rightText}>{item.location}</Text>
                  </View>

                  <Text>{item.description}</Text>
                </View>
              ))}
            </View>
          </View>
        ) : null}

        {(resume?.primary_skill_items?.length > 0 || resume?.secondary_skill_items?.length > 0) ? (
          <View>
            <Text style={styles.sectionTitle}>{t('candidates.my_resume.show.skills').toUpperCase()}</Text>

            {resume?.primary_skill_items?.length > 0 ? (
              <View style={styles.skills.line}>
                {resume.primary_skill_items.map((item, index) => (
                  <Text key={item.id} style={styles.skills.line.primary}>
                    {item.name}
                    {resume.primary_skill_items.length !== index + 1 ? ' - ' : null}
                  </Text>
                ))}
              </View>
            ) : null}

            {resume?.secondary_skill_items?.length > 0 ? (
              <View style={styles.skills.line}>
                {resume.secondary_skill_items.map((item, index) => (
                  <Text key={item.id}>
                    {item.name}
                    {resume.secondary_skill_items.length !== index + 1 ? ' - ' : null}
                  </Text>
                ))}
              </View>
            ) : null}
          </View>
        ) : null}

        {resume?.external_link_items?.length > 0 ? (
          <View>
            <Text style={styles.sectionTitle}>{t('candidates.my_resume.show.external_links').toUpperCase()}</Text>

            {resume.external_link_items.map((item) => (
              <View key={item.id} style={styles.externalLinks.item}>
                <Text style={styles.externalLinks.item.site}>
                  {item.name}
                  {'  '}
                </Text>
                <Text>
                  -
                </Text>
                <Text>
                  {'  '}
                  {item.url}
                </Text>
              </View>
            ))}
          </View>
        ) : null}

        {(resume?.personal_reference_items?.length > 0 || resume?.job_reference_items?.length > 0) ? (
          <View style={styles.references}>
            {resume?.personal_reference_items?.length > 0 ? (
              <View style={styles.references.personal}>
                <Text style={styles.sectionTitle}>
                  {t('candidates.my_resume.show.personal_references').toUpperCase()}
                </Text>

                {resume.personal_reference_items.map((item) => (
                  <View key={item.id} style={styles.references.item}>
                    <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
                      <Text style={styles.references.item.line.rightText}>
                        {item.name}
                      </Text>

                      <Text style={styles.references.item.line.leftText}>
                        {item.mobile}
                      </Text>
                    </View>

                    <View style={styles.references.item.line}>
                      <Text style={styles.references.item.line.rightText}>
                        {item.company}
                      </Text>

                      <Text style={styles.references.item.line.leftText}>
                        {item.position}
                      </Text>
                    </View>
                  </View>
                ))}
              </View>
            ) : null}

            {resume?.job_reference_items?.length > 0 ? (
              <View style={styles.references.job}>
                <Text style={styles.sectionTitle}>{t('candidates.my_resume.show.job_references').toUpperCase()}</Text>

                {resume.job_reference_items.map((item) => (
                  <View key={item.id} style={styles.references.item}>
                    <View style={{ ...styles.references.item.line, ...styles.references.item.line.firstLine }}>
                      <Text style={styles.references.item.line.rightText}>
                        {item.name}
                      </Text>

                      <Text style={styles.references.item.line.leftText}>
                        {item.mobile}
                      </Text>
                    </View>

                    <View style={styles.references.item.line}>
                      <Text style={styles.references.item.line.rightText}>
                        {item.company}
                      </Text>

                      <Text style={styles.references.item.line.leftText}>
                        {item.position}
                      </Text>
                    </View>
                  </View>
                ))}
              </View>
            ) : null}
          </View>
        ) : null}
      </Page>
    </Document>
  );
};

Pdf.propTypes = {
  resume: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    email: PropTypes.string,
    mobile: PropTypes.string,
    location: PropTypes.string,
    about_me: PropTypes.string,
    education_items: PropTypes.arrayOf(PropTypes.shape({})),
    work_experience_items: PropTypes.arrayOf(PropTypes.shape({})),
    primary_skill_items: PropTypes.arrayOf(PropTypes.shape({})),
    secondary_skill_items: PropTypes.arrayOf(PropTypes.shape({})),
    personal_reference_items: PropTypes.arrayOf(PropTypes.shape({})),
    external_link_items: PropTypes.arrayOf(PropTypes.shape({})),
    job_reference_items: PropTypes.arrayOf(PropTypes.shape({}))
  })
};

Pdf.defaultProps = {
  resume: null
};

export default Pdf;
