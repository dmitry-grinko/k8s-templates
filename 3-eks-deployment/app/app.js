const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'Hello from Kubernetes',
    timestamp: new Date(),
    pod: process.env.HOSTNAME || 'unknown'
  });
});

app.listen(port, () => {
  console.log(`Test application listening on port ${port}`);
}); 