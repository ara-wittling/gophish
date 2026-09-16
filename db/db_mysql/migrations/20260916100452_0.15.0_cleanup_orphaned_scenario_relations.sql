-- +goose Up

-- Remove campaign scenario relations where either side no longer exists
DELETE FROM campaign_scenarios
WHERE NOT EXISTS (
    SELECT 1
    FROM campaigns
    WHERE campaigns.id = campaign_scenarios.campaign_id
)
OR NOT EXISTS (
    SELECT 1
    FROM scenarios
    WHERE scenarios.id = campaign_scenarios.scenario_id
);

-- Remove scenario template relations where either side no longer exists
DELETE FROM scenario_templates
WHERE NOT EXISTS (
    SELECT 1
    FROM scenarios
    WHERE scenarios.id = scenario_templates.scenario_id
)
OR NOT EXISTS (
    SELECT 1
    FROM templates
    WHERE templates.id = scenario_templates.template_id
);

-- +goose Down

-- Data cleanup cannot be reversed because the deleted associations referenced records that no longer exist.