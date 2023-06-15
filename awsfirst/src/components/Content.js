import React, { useState, useEffect } from 'react';
import Accordion from 'react-bootstrap/Accordion';

function Content() {
  const [data, setData] = useState([]);

  useEffect(() => {
    fetch('https://wk8t22cep4.execute-api.eu-west-2.amazonaws.com/items')
      .then(response => response.json())
      .then(jsonData => setData(jsonData))
      .catch(error => console.error(error));
  }, []);

  return (
    <Accordion defaultActiveKey="0">
      {data.map((item, index) => (
        <Accordion.Item key={index} eventKey={index.toString()}>
          <Accordion.Header>{item.title}</Accordion.Header>
          <Accordion.Body>{item.description}</Accordion.Body>
        </Accordion.Item>
      ))}
    </Accordion>
  );
}

export default Content;
