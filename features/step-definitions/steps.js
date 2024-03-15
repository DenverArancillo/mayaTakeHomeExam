import { Given, When, Then } from '@wdio/cucumber-framework'
import { expect, $, browser } from '@wdio/globals'

const fetchData = async path => await fetch(`${browser.options.baseUrl}${path}`)
const isObjectEmpty = objectName => (objectName && Object.keys(objectName).length === 0 && objectName.constructor === Object)

let api = {}

Given('I send a request to get cat breeds with limit of {string} with status code {int}', async (limit, statusCode) => {
    let request = await fetchData(`/breeds?limit=${limit}`)
    api.response = await request.json()
    // console.log(api.response)
    await expect(request.status).toBe(statusCode)
})

Then('Count of cat breeds should be {int}', async length => {
    await expect(api.response.data).toHaveLength(length)
})

Then('Response message should be {string}', async message => {
    await expect(api.response.message).toBe(message)
})

Given('I send a request to get a cat fact with max length of {string} with status code {int}', async (maxLength, statusCode) => {
    let request = await fetchData(`/fact?max_length=${maxLength}`)
    api.response = await request.json()
    // console.log(api.response)
    await expect(request.status).toBe(statusCode)
})

Then('Cat fact response length should be less than or equal to {int}', async length => {
    await expect(api.response.fact.length).toBeLessThanOrEqual(length)
})

Then('Cat fact reponse should be empty', async () => {
    await expect(api.response).toMatchObject({})
})

Then('Cat fact response should not be empty', async () => {
    await expect(isObjectEmpty(api.response)).toBeFalsy()
})

Then('Cat fact response should contain the property {string}', async prop => {
    await expect(api.response).toHaveProperty(prop)
})

Given('I send a request to get cat facts with limit of {string} and max length of {string} with status code {int}', async (limit, maxLength, statusCode) => {
    let request = await fetchData(`/facts?max_length=${maxLength}&limit=${limit}`)
    api.response = await request.json()
    // console.log(api.response)
    await expect(request.status).toBe(statusCode)
})

Then('Count of cat facts should be less than or equal to {int}', async length => {
    await expect(api.response.data.length).toBeLessThanOrEqual(length)
})

Then('Length of all cat facts should be less than or equal to {int}', async length => {
    await expect(api.response.data.every(fact => fact.length <= length)).toBeTruthy()
})
