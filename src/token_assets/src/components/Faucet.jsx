import React, { useState } from 'react';

import { token } from '../../../declarations/token';

function Faucet() {
  const [isDisabled, setDisabled] = useState(false);
  const [buttonText, setText] = useState('gimme gimme');

  async function handleClick(event) {
    setDisabled(true);
    const result = await token.payOut();
    setText(result);
  }

  return (
    <div className='blue window'>
      <h2>
        <span role='img' aria-label='tap emoji'>
          🚰
        </span>
        Faucet
      </h2>
      <label>
        Get your free DAngela tokens here! Claim 10,000 DANG coins to your
        account.
      </label>
      <p className='trade-buttons'>
        <button id='btn-payout' onClick={handleClick} disabled={isDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
