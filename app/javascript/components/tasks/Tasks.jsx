import React, { useEffect, useState } from 'react';
import { Checkbox, List } from 'semantic-ui-react';
import { getTasks } from '../../common/api';

export default () => {
    const [tasks, setTasks] = useState([]);

    useEffect(() => {
        const init = async () => {
            const data = await getTasks();
            setTasks(data);
        };

        init();
    }, []);

    const displayTasks = (taskArray) =>
        taskArray.map((task) => (
            <List.Item>
                <div style={{ display: 'flex' }}>
                    <Checkbox />
                    <List.Header>{task.title}</List.Header>
                </div>
            </List.Item>
        ));

    return <List>{displayTasks(tasks)}</List>;
};
