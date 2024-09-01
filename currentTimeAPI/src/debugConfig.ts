import debug from 'debug';

// Function to set debug namespaces programmatically
export const setDebugNamespaces = (namespaces: string) => {
    process.env.DEBUG = namespaces;
};

// Set debug namespaces as needed (initial configuration)
setDebugNamespaces('app:server');

// Export a debug instance with the specified namespace
export const log = debug('app:server');
