import React, { useState } from 'react';

const App = () => {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>
        You clicked
        {' '}
        {count}
        {' '}
        times!
      </p>

      <button type="button" onClick={() => setCount((prevCount) => prevCount + 1)}>
        Click Me!
      </button>
    </div>
  );
};

export default App;
