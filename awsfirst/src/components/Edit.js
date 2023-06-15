import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';

function EditPage() {
  return (
    <Form className='formStyle'>
        <h1>Add new card:</h1>

        <Form.Group className="mb-3">
        <Form.Label>ID</Form.Label>
        <Form.Control placeholder="Enter ID" />
      </Form.Group>

      <Form.Group className="mb-3">
        <Form.Label>Title</Form.Label>
        <Form.Control placeholder="Enter title" />
      </Form.Group>

      <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
        <Form.Label>Description</Form.Label>
        <Form.Control as="textarea" rows={3} placeholder='Enter description' />
      </Form.Group>
      <Button variant="primary" type="submit">
        Submit
      </Button>
    </Form>
  );
}

export default EditPage;