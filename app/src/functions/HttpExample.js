/* global process setTimeout */
'use strict';
const { app, output } = require('@azure/functions');
const { BlobServiceClient } = require('@azure/storage-blob');
const {hostname} = require('node:os');
const fs = require('node:fs/promises')

app.http('HttpExample', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);
        return { body: JSON.stringify({ hello: "world"}, null, 2), headers: { 'Content-Type': 'application/json' } };
    }
});

app.timer('TimerExample', {
    schedule: '* * * * * *',
    handler: async (myTimer, context) => {
        context.log('Timer example');
    },
});

async function warmup(context) {
    try {
        context.log(`[${hostname()} ${process.pid}] Warmup function executing`);
        context.log(`[${hostname()} ${process.pid}] Warmup OK`);
    } catch (e) {
        context.log(`[${hostname()} ${process.pid}] Warmup error: ${e.message}`);
    }
}

app.warmup('warmupTrigger', {
    handler: (w,c) => warmup(c),
});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
