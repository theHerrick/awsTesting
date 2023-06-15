import React from "react";
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import NavHeader from "./components/NavHeader";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Content from "./components/Content";
import EditPage from "./components/Edit";

function App() {
  return (
    <Router>
    <NavHeader />
    <Container fluid>
      <Row>
        <Col>
          <img src="static/images/awslogo.png" alt="aws logo" />
        </Col>
      </Row>
      <Row>
        <Col>
      <Routes>
        <Route path="/" element={<Content />} />
        <Route path="/edit" element={<EditPage />} />
      </Routes>
        </Col>
      </Row>
    </Container>
    </Router>
  );
}

export default App;
