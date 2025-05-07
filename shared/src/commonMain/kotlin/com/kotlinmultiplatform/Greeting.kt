package com.kotlinmultiplatform

import kotlin.random.Random

class Greeting {
    private val platform = getPlatform()

    fun greet(): String {
        val firstWorld = if (Random.nextBoolean()) "Hi!" else "Hello!"
        return "$firstWorld [$num] Guess what this is! > ${platform.name.reversed()}!"
    }
}