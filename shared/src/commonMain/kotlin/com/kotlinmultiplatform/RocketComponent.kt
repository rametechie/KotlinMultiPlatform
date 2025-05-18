package com.kotlinmultiplatform

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText
import io.ktor.http.isSuccess
import io.ktor.serialization.kotlinx.json.json
import kotlinx.datetime.Instant
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toLocalDateTime
import kotlinx.serialization.json.Json

class RocketComponent {
    private val httpClient = HttpClient {
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }
            )
        }
    }

    private suspend fun getDateOfLastSuccessfulLaunch(): String {
        val response = httpClient.get("https://api.spacexdata.com/v4/launches/latest")

        // Log HTTP status
        Log.logger.i { "Http status: ${response.status}" }

        // Check for 200 OK
        if (!response.status.isSuccess()) {
            Log.logger.e { "Request failed with status: ${response.status}" }
            throw Exception("Failed to fetch launches")
        }

        // Deserialize into typed object
        val rockets: RocketLaunch = response.body()
        Log.logger.i { "rockets :\n$rockets" }

        Log.logger.i { "lastSuccessLaunch :\n$rockets" }
        val date = Instant.parse(rockets.launchDateUTC)
            .toLocalDateTime(TimeZone.currentSystemDefault())

        Log.logger.i { "date :\n$date" }
        return "${date.month} ${date.dayOfMonth}, ${date.year}"
    }

    suspend fun launchPhrase(): String =
        try {
            "The last successful launch was on ${getDateOfLastSuccessfulLaunch()} 🚀"
        } catch (e: Exception) {
            println("Exception during getting the date of the last successful launch $e")
            "Error occurred"
        }
}