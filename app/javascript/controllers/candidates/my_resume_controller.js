import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';
// eslint-disable-next-line import/no-extraneous-dependencies
import { Provider } from 'react-redux';

import configureStore from '../../components/candidates/my_resume/store/configureStore';
import MyResume from '../../components/candidates/my_resume';

export default class extends Controller {
  connect() {
    const store = configureStore();

    const root = createRoot(document.getElementById('candidates-my-resume-container'));

    root.render(
      <Provider store={store}>
        <MyResume />
      </Provider>
    );
  }
}
