import ReactDOM from 'react-dom';
import React from 'react';
import App from './components/App';
import { AuthClient } from '@dfinity/auth-client';
import { AuthClient } from '../../../node_modules/@dfinity/auth-client/lib/cjs/index';

const init = async () => {
  const authClient = await AuthClient.create();

  if (await authClient.isAuthenticated()) {
    handleAuthenticated(AuthClient);
  } else {
    await authClient.login({
      identityProvider: 'https://identity.ic0.app/#authorize',
      onSuccess: () => {
        handleAuthenticated(authClient);
      },
    });
  }
};
async function handleAuthenticated(authClient) {
  ReactDOM.render(<App />, document.getElementById('root'));
}

init();
