import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from 'semantic-ui-react';

export default () => (
    <div>
        <h1>COMPLETIONIST</h1>
        <Link to='/tasks' role='button'>
            <Button primary>View Your To-Do List</Button>
        </Link>
    </div>
);
