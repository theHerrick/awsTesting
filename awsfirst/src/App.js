import NavHeader from "./components/NavHeader";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

function App() {
  return (
    <>
    <NavHeader />
   
    <Container fluid>
      <Row>
        <Col>
          <img src="static/images/awslogo.png" alt="aws logo" />
        </Col>
      </Row>
    </Container>
    </>
  );
}

export default App;
