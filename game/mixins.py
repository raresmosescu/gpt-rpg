from gpt.models.davinci import create_or_get_instance


class KeywordMixin:
    """
    A mixin to add the functionality of fetching keywords using GPT-3 API.
    """

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.davinci3 = create_or_get_instance()

    def fetch_keywords(self, text):
        """
        Fetch the keywords for the given text using the GPT-3 API.
        """
        instruction = (
            "List the key words that are mentioned in the text above, "
            "maximum 2 words per listing, as comma-separated values:"
        )

        comma_separated_keywords = self.davinci3.complete(
            "Text: " + text + "\n\n" + instruction
        )
        return comma_separated_keywords
