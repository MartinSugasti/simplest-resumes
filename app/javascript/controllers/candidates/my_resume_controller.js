import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';
// eslint-disable-next-line import/no-extraneous-dependencies
import { createStore } from 'redux';
import { Provider } from 'react-redux';

import reducer from '../../components/candidates/my_resume/store/reducers';
import MyResume from '../../components/candidates/my_resume';

export default class extends Controller {
  connect() {
    const store = createStore(
      reducer,
      {},
      // eslint-disable-next-line no-underscore-dangle
      window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
    );

    const root = createRoot(document.getElementById('candidates-my-resume-container'));

    root.render(
      <Provider store={store}>
        <MyResume />
      </Provider>
    );
  }
}
