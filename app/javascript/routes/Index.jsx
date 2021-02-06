import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import Home from '../components/home/Home';
import Tasks from '../components/tasks/Tasks';

export default (
    <Router>
        <Switch>
            <Route path='/' exact component={Home} />
            <Route path='/tasks' exact component={Tasks} />
        </Switch>
    </Router>
);
