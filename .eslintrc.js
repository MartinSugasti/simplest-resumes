module.exports = {
  root: true,
  extends: ['airbnb', 'airbnb/hooks'],
  rules: {
    'react/jsx-filename-extension': [1, { extensions: ['.js', '.jsx'] }],
    'react/function-component-definition': [1, { namedComponents: 'arrow-function' }],
    'no-console': 0,
    'no-alert': 0,
    'comma-dangle': ['error', 'never'],
    'jsx-a11y/label-has-associated-control': ['error', { required: { some: ['nesting', 'id'] } }],
    'no-restricted-exports': ['error', { restrictedNamedExports: [] }],
    'max-len': ['error', { code: 120 }]
  },
  globals: {
    document: 'readonly'
  },
  env: {
    browser: true
  },
  parserOptions: {
    ecmaVersion: 2020
  }
};
