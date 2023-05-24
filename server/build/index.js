"use strict";
// Server code from https://github.com/stripe-samples/accept-a-card-payment/tree/master/using-webhooks/server/node-typescript
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var body_parser_1 = __importDefault(require("body-parser"));
var dotenv_1 = __importDefault(require("dotenv"));
var express_1 = __importDefault(require("express"));
var stripe_1 = __importDefault(require("stripe"));
var cors_1 = __importDefault(require("cors"));
var utils_1 = require("./utils");
// Replace if using a different env file or config.
dotenv_1.default.config({ path: './.env' });
var stripePublishableKey = process.env.STRIPE_PUBLISHABLE_KEY || '';
var stripeSecretKey = process.env.STRIPE_SECRET_KEY || '';
var stripeWebhookSecret = process.env.STRIPE_WEBHOOK_SECRET || '';
var app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use(function (req, res, next) {
    if (req.originalUrl === '/webhook') {
        next();
    }
    else {
        /* @ts-ignore */
        body_parser_1.default.json()(req, res, next);
    }
});
var calculateOrderAmount = function (_order) {
    // Replace this constant with a calculation of the order's amount.
    // Calculate the order total on the server to prevent
    // people from directly manipulating the amount on the client.
    return 1400;
};
function getKeys(payment_method) {
    var secret_key = stripeSecretKey;
    var publishable_key = stripePublishableKey;
    switch (payment_method) {
        case 'grabpay':
        case 'fpx':
            publishable_key = process.env.STRIPE_PUBLISHABLE_KEY_MY;
            secret_key = process.env.STRIPE_SECRET_KEY_MY;
            break;
        case 'au_becs_debit':
            publishable_key = process.env.STRIPE_PUBLISHABLE_KEY_AU;
            secret_key = process.env.STRIPE_SECRET_KEY_AU;
            break;
        case 'oxxo':
            publishable_key = process.env.STRIPE_PUBLISHABLE_KEY_MX;
            secret_key = process.env.STRIPE_SECRET_KEY_MX;
            break;
        case 'wechat_pay':
            publishable_key = process.env.STRIPE_PUBLISHABLE_KEY_WECHAT;
            secret_key = process.env.STRIPE_SECRET_KEY_WECHAT;
            break;
        default:
            publishable_key = process.env.STRIPE_PUBLISHABLE_KEY;
            secret_key = process.env.STRIPE_SECRET_KEY;
    }
    return { secret_key: secret_key, publishable_key: publishable_key };
}
app.get('/stripe-key', function (req, res) {
    var publishable_key = getKeys(req.query.paymentMethod).publishable_key;
    return res.send({ publishableKey: publishable_key });
});
app.post('/create-payment-intent', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _a, email, items, currency, request_three_d_secure, _b, payment_method_types, _c, client, secret_key, stripe, customer, params, paymentIntent, error_1;
    return __generator(this, function (_d) {
        switch (_d.label) {
            case 0:
                _a = req.body, email = _a.email, items = _a.items, currency = _a.currency, request_three_d_secure = _a.request_three_d_secure, _b = _a.payment_method_types, payment_method_types = _b === void 0 ? [] : _b, _c = _a.client, client = _c === void 0 ? 'ios' : _c;
                secret_key = getKeys(payment_method_types[0]).secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                return [4 /*yield*/, stripe.customers.create({ email: email })];
            case 1:
                customer = _d.sent();
                params = {
                    amount: calculateOrderAmount(items),
                    currency: currency,
                    customer: customer.id,
                    payment_method_options: {
                        card: {
                            request_three_d_secure: request_three_d_secure || 'automatic',
                        },
                        sofort: {
                            preferred_language: 'en',
                        },
                        wechat_pay: {
                            app_id: 'wx65907d6307c3827d',
                            client: client,
                        },
                    },
                    payment_method_types: payment_method_types,
                };
                _d.label = 2;
            case 2:
                _d.trys.push([2, 4, , 5]);
                return [4 /*yield*/, stripe.paymentIntents.create(params)];
            case 3:
                paymentIntent = _d.sent();
                // Send publishable key and PaymentIntent client_secret to client.
                return [2 /*return*/, res.send({
                        clientSecret: paymentIntent.client_secret,
                    })];
            case 4:
                error_1 = _d.sent();
                return [2 /*return*/, res.send({
                        error: error_1.raw.message,
                    })];
            case 5: return [2 /*return*/];
        }
    });
}); });
app.post('/create-payment-intent-with-payment-method', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _a, items, currency, request_three_d_secure, email, secret_key, stripe, customers, paymentMethods, params, paymentIntent;
    return __generator(this, function (_b) {
        switch (_b.label) {
            case 0:
                _a = req.body, items = _a.items, currency = _a.currency, request_three_d_secure = _a.request_three_d_secure, email = _a.email;
                secret_key = getKeys().secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                return [4 /*yield*/, stripe.customers.list({
                        email: email,
                    })];
            case 1:
                customers = _b.sent();
                // The list all Customers endpoint can return multiple customers that share the same email address.
                // For this example we're taking the first returned customer but in a production integration
                // you should make sure that you have the right Customer.
                if (!customers.data[0]) {
                    return [2 /*return*/, res.send({
                            error: 'There is no associated customer object to the provided e-mail',
                        })];
                }
                return [4 /*yield*/, stripe.paymentMethods.list({
                        customer: customers.data[0].id,
                        type: 'card',
                    })];
            case 2:
                paymentMethods = _b.sent();
                if (!paymentMethods.data[0]) {
                    return [2 /*return*/, res.send({
                            error: "There is no associated payment method to the provided customer's e-mail",
                        })];
                }
                params = {
                    amount: calculateOrderAmount(items),
                    currency: currency,
                    payment_method_options: {
                        card: {
                            request_three_d_secure: request_three_d_secure || 'automatic',
                        },
                    },
                    payment_method: paymentMethods.data[0].id,
                    customer: customers.data[0].id,
                };
                return [4 /*yield*/, stripe.paymentIntents.create(params)];
            case 3:
                paymentIntent = _b.sent();
                // Send publishable key and PaymentIntent client_secret to client.
                return [2 /*return*/, res.send({
                        clientSecret: paymentIntent.client_secret,
                        paymentMethodId: paymentMethods.data[0].id,
                    })];
        }
    });
}); });
app.post('/pay-without-webhooks', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _a, paymentMethodId, paymentIntentId, items, currency, useStripeSdk, cvcToken, email, orderAmount, secret_key, stripe, customers, paymentMethods, params, intent, params, intent, intent, e_1;
    return __generator(this, function (_b) {
        switch (_b.label) {
            case 0:
                _a = req.body, paymentMethodId = _a.paymentMethodId, paymentIntentId = _a.paymentIntentId, items = _a.items, currency = _a.currency, useStripeSdk = _a.useStripeSdk, cvcToken = _a.cvcToken, email = _a.email;
                orderAmount = calculateOrderAmount(items);
                secret_key = getKeys().secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                _b.label = 1;
            case 1:
                _b.trys.push([1, 10, , 11]);
                if (!(cvcToken && email)) return [3 /*break*/, 5];
                return [4 /*yield*/, stripe.customers.list({
                        email: email,
                    })];
            case 2:
                customers = _b.sent();
                // The list all Customers endpoint can return multiple customers that share the same email address.
                // For this example we're taking the first returned customer but in a production integration
                // you should make sure that you have the right Customer.
                if (!customers.data[0]) {
                    return [2 /*return*/, res.send({
                            error: 'There is no associated customer object to the provided e-mail',
                        })];
                }
                return [4 /*yield*/, stripe.paymentMethods.list({
                        customer: customers.data[0].id,
                        type: 'card',
                    })];
            case 3:
                paymentMethods = _b.sent();
                if (!paymentMethods.data[0]) {
                    return [2 /*return*/, res.send({
                            error: "There is no associated payment method to the provided customer's e-mail",
                        })];
                }
                params = {
                    amount: orderAmount,
                    confirm: true,
                    confirmation_method: 'manual',
                    currency: currency,
                    payment_method: paymentMethods.data[0].id,
                    payment_method_options: {
                        card: {
                            cvc_token: cvcToken,
                        },
                    },
                    use_stripe_sdk: useStripeSdk,
                    customer: customers.data[0].id,
                };
                return [4 /*yield*/, stripe.paymentIntents.create(params)];
            case 4:
                intent = _b.sent();
                return [2 /*return*/, res.send((0, utils_1.generateResponse)(intent))];
            case 5:
                if (!paymentMethodId) return [3 /*break*/, 7];
                params = {
                    amount: orderAmount,
                    confirm: true,
                    confirmation_method: 'manual',
                    currency: currency,
                    payment_method: paymentMethodId,
                    // If a mobile client passes `useStripeSdk`, set `use_stripe_sdk=true`
                    // to take advantage of new authentication features in mobile SDKs.
                    use_stripe_sdk: useStripeSdk,
                };
                return [4 /*yield*/, stripe.paymentIntents.create(params)];
            case 6:
                intent = _b.sent();
                // After create, if the PaymentIntent's status is succeeded, fulfill the order.
                return [2 /*return*/, res.send((0, utils_1.generateResponse)(intent))];
            case 7:
                if (!paymentIntentId) return [3 /*break*/, 9];
                return [4 /*yield*/, stripe.paymentIntents.confirm(paymentIntentId)];
            case 8:
                intent = _b.sent();
                // After confirm, if the PaymentIntent's status is succeeded, fulfill the order.
                return [2 /*return*/, res.send((0, utils_1.generateResponse)(intent))];
            case 9: return [2 /*return*/, res.sendStatus(400)];
            case 10:
                e_1 = _b.sent();
                // Handle "hard declines" e.g. insufficient funds, expired card, etc
                // See https://stripe.com/docs/declines/codes for more.
                return [2 /*return*/, res.send({ error: e_1.message })];
            case 11: return [2 /*return*/];
        }
    });
}); });
app.post('/create-setup-intent', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _a, email, _b, payment_method_types, secret_key, stripe, customer, setupIntent;
    return __generator(this, function (_c) {
        switch (_c.label) {
            case 0:
                _a = req.body, email = _a.email, _b = _a.payment_method_types, payment_method_types = _b === void 0 ? [] : _b;
                secret_key = getKeys(payment_method_types[0]).secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                return [4 /*yield*/, stripe.customers.create({ email: email })];
            case 1:
                customer = _c.sent();
                return [4 /*yield*/, stripe.setupIntents.create({
                        customer: customer.id,
                        payment_method_types: payment_method_types,
                    })];
            case 2:
                setupIntent = _c.sent();
                // Send publishable key and SetupIntent details to client
                return [2 /*return*/, res.send({
                        publishableKey: process.env.STRIPE_PUBLISHABLE_KEY,
                        clientSecret: setupIntent.client_secret,
                    })];
        }
    });
}); });
// Expose a endpoint as a webhook handler for asynchronous events.
// Configure your webhook in the stripe developer dashboard:
// https://dashboard.stripe.com/test/webhooks
app.post('/webhook', 
// Use body-parser to retrieve the raw body as a buffer.
/* @ts-ignore */
body_parser_1.default.raw({ type: 'application/json' }), function (req, res) {
    // Retrieve the event by verifying the signature using the raw body and secret.
    var event;
    var secret_key = getKeys().secret_key;
    var stripe = new stripe_1.default(secret_key, {
        apiVersion: '2020-08-27',
        typescript: true,
    });
    // console.log('webhook!', req);
    try {
        event = stripe.webhooks.constructEvent(req.body, req.headers['stripe-signature'] || [], stripeWebhookSecret);
    }
    catch (err) {
        console.log("\u26A0\uFE0F  Webhook signature verification failed.");
        return res.sendStatus(400);
    }
    // Extract the data from the event.
    var data = event.data;
    var eventType = event.type;
    if (eventType === 'payment_intent.succeeded') {
        // Cast the event into a PaymentIntent to make use of the types.
        var pi = data.object;
        // Funds have been captured
        // Fulfill any orders, e-mail receipts, etc
        // To cancel the payment after capture you will need to issue a Refund (https://stripe.com/docs/api/refunds).
        console.log("\uD83D\uDD14  Webhook received: ".concat(pi.object, " ").concat(pi.status, "!"));
        console.log('💰 Payment captured!');
    }
    if (eventType === 'payment_intent.payment_failed') {
        // Cast the event into a PaymentIntent to make use of the types.
        var pi = data.object;
        console.log("\uD83D\uDD14  Webhook received: ".concat(pi.object, " ").concat(pi.status, "!"));
        console.log('❌ Payment failed.');
    }
    if (eventType === 'setup_intent.setup_failed') {
        console.log("\uD83D\uDD14  A SetupIntent has failed the to setup a PaymentMethod.");
    }
    if (eventType === 'setup_intent.succeeded') {
        console.log("\uD83D\uDD14  A SetupIntent has successfully setup a PaymentMethod for future use.");
    }
    if (eventType === 'setup_intent.created') {
        var setupIntent = data.object;
        console.log("\uD83D\uDD14  A new SetupIntent is created. ".concat(setupIntent.id));
    }
    return res.sendStatus(200);
});
// An endpoint to charge a saved card
// In your application you may want a cron job / other internal process
app.post('/charge-card-off-session', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var paymentIntent, customer, secret_key, stripe, paymentMethods, err_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                secret_key = getKeys().secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                _a.label = 1;
            case 1:
                _a.trys.push([1, 5, , 6]);
                return [4 /*yield*/, stripe.customers.list({
                        email: req.body.email,
                    })];
            case 2:
                // You need to attach the PaymentMethod to a Customer in order to reuse
                // Since we are using test cards, create a new Customer here
                // You would do this in your payment flow that saves cards
                customer = _a.sent();
                return [4 /*yield*/, stripe.paymentMethods.list({
                        customer: customer.data[0].id,
                        type: 'card',
                    })];
            case 3:
                paymentMethods = _a.sent();
                return [4 /*yield*/, stripe.paymentIntents.create({
                        amount: calculateOrderAmount(),
                        currency: 'usd',
                        payment_method: paymentMethods.data[0].id,
                        customer: customer.data[0].id,
                        off_session: true,
                        confirm: true,
                    })];
            case 4:
                // Create and confirm a PaymentIntent with the order amount, currency,
                // Customer and PaymentMethod ID
                paymentIntent = _a.sent();
                return [2 /*return*/, res.send({
                        succeeded: true,
                        clientSecret: paymentIntent.client_secret,
                        publicKey: stripePublishableKey,
                    })];
            case 5:
                err_1 = _a.sent();
                if (err_1.code === 'authentication_required') {
                    // Bring the customer back on-session to authenticate the purchase
                    // You can do this by sending an email or app notification to let them know
                    // the off-session purchase failed
                    // Use the PM ID and client_secret to authenticate the purchase
                    // without asking your customers to re-enter their details
                    return [2 /*return*/, res.send({
                            error: 'authentication_required',
                            paymentMethod: err_1.raw.payment_method.id,
                            clientSecret: err_1.raw.payment_intent.client_secret,
                            publicKey: stripePublishableKey,
                            amount: calculateOrderAmount(),
                            card: {
                                brand: err_1.raw.payment_method.card.brand,
                                last4: err_1.raw.payment_method.card.last4,
                            },
                        })];
                }
                else if (err_1.code) {
                    // The card was declined for other reasons (e.g. insufficient funds)
                    // Bring the customer back on-session to ask them for a new payment method
                    return [2 /*return*/, res.send({
                            error: err_1.code,
                            clientSecret: err_1.raw.payment_intent.client_secret,
                            publicKey: stripePublishableKey,
                        })];
                }
                else {
                    console.log('Unknown error occurred', err_1);
                    return [2 /*return*/, res.sendStatus(500)];
                }
                return [3 /*break*/, 6];
            case 6: return [2 /*return*/];
        }
    });
}); });
// This example sets up an endpoint using the Express framework.
// Watch this video to get started: https://youtu.be/rPR2aJ6XnAc.
app.post('/payment-sheet', function (_, res) { return __awaiter(void 0, void 0, void 0, function () {
    var secret_key, stripe, customers, customer, ephemeralKey, paymentIntent;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                secret_key = getKeys().secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                return [4 /*yield*/, stripe.customers.list()];
            case 1:
                customers = _a.sent();
                customer = customers.data[0];
                if (!customer) {
                    return [2 /*return*/, res.send({
                            error: 'You have no customer created',
                        })];
                }
                return [4 /*yield*/, stripe.ephemeralKeys.create({ customer: customer.id }, { apiVersion: '2020-08-27' })];
            case 2:
                ephemeralKey = _a.sent();
                return [4 /*yield*/, stripe.paymentIntents.create({
                        amount: 5099,
                        currency: 'usd',
                        customer: customer.id,
                        shipping: {
                            name: 'Jane Doe',
                            address: {
                                state: 'Texas',
                                city: 'Houston',
                                line1: '1459  Circle Drive',
                                postal_code: '77063',
                                country: 'US',
                            },
                        },
                        // Edit the following to support different payment methods in your PaymentSheet
                        // Note: some payment methods have different requirements: https://stripe.com/docs/payments/payment-methods/integration-options
                        payment_method_types: [
                            'card',
                            // 'ideal',
                            // 'sepa_debit',
                            // 'sofort',
                            // 'bancontact',
                            // 'p24',
                            // 'giropay',
                            // 'eps',
                            // 'afterpay_clearpay',
                            // 'klarna',
                        ],
                    })];
            case 3:
                paymentIntent = _a.sent();
                return [2 /*return*/, res.json({
                        paymentIntent: paymentIntent.client_secret,
                        ephemeralKey: ephemeralKey.secret,
                        customer: customer.id,
                    })];
        }
    });
}); });
app.post('/create-checkout-session', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var port, effectivePort, secret_key, stripe, session;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                port = req.body.port;
                effectivePort = port !== null && port !== void 0 ? port : 8080;
                secret_key = getKeys().secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                return [4 /*yield*/, stripe.checkout.sessions.create({
                        payment_method_types: ['card'],
                        line_items: [
                            {
                                price_data: {
                                    currency: 'usd',
                                    product_data: {
                                        name: 'Stubborn Attachments',
                                        images: ['https://i.imgur.com/EHyR2nP.png'],
                                    },
                                    unit_amount: 2000,
                                },
                                quantity: 1,
                            },
                        ],
                        mode: 'payment',
                        success_url: "https://checkout.stripe.dev/success",
                        cancel_url: "https://checkout.stripe.dev/cancel",
                    })];
            case 1:
                session = _a.sent();
                res.json({ id: session.id });
                return [2 /*return*/];
        }
    });
}); });
// An endpoint to charge a saved card
// In your application you may want a cron job / other internal process
app.post('/universal-payment', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var paymentIntent, customer, secret_key, stripe, err_2;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                _a.trys.push([0, 2, , 3]);
                secret_key = getKeys().secret_key;
                stripe = new stripe_1.default(secret_key, {
                    apiVersion: '2020-08-27',
                    typescript: true,
                });
                return [4 /*yield*/, stripe.paymentIntents.create({
                        amount: calculateOrderAmount(),
                        currency: 'eur',
                        payment_method_types: ['bancontact', 'card', 'ideal'],
                        //customer: customer.data[0].id,
                    })];
            case 1:
                // You need to attach the PaymentMethod to a Customer in order to reuse
                // Since we are using test cards, create a new Customer here
                // You would do this in your payment flow that saves cards
                //  customer = await stripe.customers.list({
                //    email: req.body.email,
                //  });
                // Create and confirm a PaymentIntent with the order amount, currency,
                // Customer and PaymentMethod ID
                paymentIntent = _a.sent();
                res.send({
                    clientSecret: paymentIntent.client_secret,
                });
                return [3 /*break*/, 3];
            case 2:
                err_2 = _a.sent();
                if (err_2.code === 'authentication_required') {
                    // Bring the customer back on-session to authenticate the purchase
                    // You can do this by sending an email or app notification to let them know
                    // the off-session purchase failed
                    // Use the PM ID and client_secret to authenticate the purchase
                    // without asking your customers to re-enter their details
                    res.send({
                        error: 'authentication_required',
                        paymentMethod: err_2.raw.payment_method.id,
                        clientSecret: err_2.raw.payment_intent.client_secret,
                        publicKey: stripePublishableKey,
                        amount: calculateOrderAmount(),
                        card: {
                            brand: err_2.raw.payment_method.card.brand,
                            last4: err_2.raw.payment_method.card.last4,
                        },
                    });
                }
                else if (err_2.code) {
                    // The card was declined for other reasons (e.g. insufficient funds)
                    // Bring the customer back on-session to ask them for a new payment method
                    res.send({
                        error: err_2.code,
                        clientSecret: err_2.raw.payment_intent.client_secret,
                        publicKey: stripePublishableKey,
                    });
                }
                else {
                    console.log('Unknown error occurred', err_2);
                }
                return [3 /*break*/, 3];
            case 3: return [2 /*return*/];
        }
    });
}); });
app.listen(4242, function () {
    return console.log("Node server listening on port ".concat(4242, "!"));
});
