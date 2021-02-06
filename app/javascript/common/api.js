import axios from 'axios';

const API_HOST = process.env.REACT_APP_BACKEND_HOST || 'localhost';
const API_PORT = process.env.REACT_APP_BACKEND_PORT || 3000;
const BASE_URL = `http://${API_HOST}:${API_PORT}/api/v1`;

const client = axios.create({
    baseURL: BASE_URL,
});

export const getTasks = async () => {
    const response = await client.get('tasks');
    return response.data;
};