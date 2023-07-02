import { useState } from 'react';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';

function EditPage() {
  const [id, setId] = useState('');
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();

    // Create the JSON object
    const data = {
      id: id,
      title: title,
      description: description
    };

    // Send the POST request using the 'fetch' function or any HTTP library of your choice
    fetch('https://fw5d18mabi.execute-api.eu-west-2.amazonaws.com/awsteam', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
      .then(response => {
        // Handle the response
        console.log('POST request successful');
        // Clear the form fields
        setId('');
        setTitle('');
        setDescription('');
      })
      .catch(error => {
        // Handle the error
        console.error('Error:', error);
      });
  };

  return (
    <Form className='formStyle' onSubmit={handleSubmit}>
      <h1>Add new card:</h1>

      <Form.Group className="mb-3">
        <Form.Label>ID</Form.Label>
        <Form.Control
          placeholder="Enter ID"
          value={id}
          onChange={(e) => setId(e.target.value)}
        />
      </Form.Group>

      <Form.Group className="mb-3">
        <Form.Label>Title</Form.Label>
        <Form.Control
          placeholder="Enter title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
        />
      </Form.Group>

      <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
        <Form.Label>Description</Form.Label>
        <Form.Control
          as="textarea"
          rows={3}
          placeholder="Enter description"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
      </Form.Group>
      
      <Button variant="primary" type="submit">
        Submit
      </Button>
    </Form>
  );
}

export default EditPage;
