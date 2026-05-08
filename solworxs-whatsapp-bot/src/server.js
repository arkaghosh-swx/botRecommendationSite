require("dotenv").config();
const express = require("express");
const cors = require("cors");
const { handleWebhook, verifyWebhook } = require("./webhook");
const { getAIReply } = require("./claude");

const app = express();
app.use(express.json());
app.use(cors()); // ← allows your website to call this server

const PORT = process.env.PORT || 3000;

// ── Meta webhook verification (GET)
app.get("/webhook", verifyWebhook);

// ── Incoming messages (POST)
app.post("/webhook", handleWebhook);

// ── Swx Bot chat proxy (hides Groq key from browser)
app.post("/api/chat", async (req, res) => {
    try {
        const { messages } = req.body;
        const reply = await getAIReply(messages);
        res.json({ reply });
    } catch (err) {
        console.error("Chat proxy error:", err.message);
        res.status(500).json({ reply: "⚠️ Something went wrong. Please try again." });
    }
});

// ── Health check
app.get("/", (req, res) => res.send("Solworxs WhatsApp Bot is running ✅"));

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));