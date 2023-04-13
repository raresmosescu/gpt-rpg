from gpt-api.wrapper import generate_text

print(
    generate_text(
        "You are a teacher. Please write a short story about a "
        "student who is late for class. Max 50 words."
    )
)