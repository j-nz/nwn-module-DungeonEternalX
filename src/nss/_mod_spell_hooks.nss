#include "x2_inc_switches"
#include "util_rangerspell"

void main()
{
    // Preserve the existing anti-cheat / AOE limiter as the first preflight.
    ExecuteScript("stop_spellcheat", OBJECT_SELF);
    if (GetModuleOverrideSpellScriptFinished()) return;

    int nSpell=GetSpellId();
    if(nSpell==AI_SPELL_SPELLSLAYER_ARROW && !AI_CanCastSpellslayerArrow(OBJECT_SELF))
    {
        SendMessageToPC(OBJECT_SELF,"Spellslayer Arrow requires a bow or crossbow with ammunition.");
        SetModuleOverrideSpellScriptFinished();
    }
}
