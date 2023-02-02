import torch.nn as nn


class IntentClassifierFinetune(nn.Module):
    def __init__(self, intent_classifier, num_past_intent_labels, num_output_labels):
        super(IntentClassifierFinetune, self).__init__()
        self.intent_classifier = intent_classifier
        self.new_classifier = nn.Linear(num_past_intent_labels, num_output_labels)

    def forward(self, x):
        x = self.intent_classifier(x)
        return self.new_classifier(x)


class SlotClassifierFinetune(nn.Module):
    def __init__(self, slot_classifier, num_slot_labels, num_new_slot_labels):
        super(SlotClassifierFinetune, self).__init__()
        self.old_classifier = slot_classifier
        self.new_classifier = nn.Linear(num_slot_labels, num_new_slot_labels)

    def forward(self, x):
        x = self.old_classifier(x)
        return self.new_classifier(x)
