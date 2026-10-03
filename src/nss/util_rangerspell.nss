#include "x2_inc_spellhook"
const int AI_SPELL_DETECT_FAVORED_ENEMIES=840;
const int AI_SPELL_SNARE=841;
const int AI_SPELL_SPELLSLAYER_ARROW=842;
const int AI_SPELL_TREESHAPE=843;
const int AI_SPELL_FORESTFOLD=844;
const int AI_VFX_PER_SNARE=47;

int AI_IsBowOrCrossbow(object oCreature)
{
 int nBase=GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCreature));
 return nBase==BASE_ITEM_LONGBOW||nBase==BASE_ITEM_SHORTBOW||nBase==BASE_ITEM_LIGHTCROSSBOW||nBase==BASE_ITEM_HEAVYCROSSBOW;
}
object AI_GetLauncherAmmo(object oCreature)
{
 int nBase=GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCreature));
 if(nBase==BASE_ITEM_LONGBOW||nBase==BASE_ITEM_SHORTBOW)return GetItemInSlot(INVENTORY_SLOT_ARROWS,oCreature);
 if(nBase==BASE_ITEM_LIGHTCROSSBOW||nBase==BASE_ITEM_HEAVYCROSSBOW)return GetItemInSlot(INVENTORY_SLOT_BOLTS,oCreature);
 return OBJECT_INVALID;
}
int AI_CanCastSpellslayerArrow(object oCreature){return AI_IsBowOrCrossbow(oCreature)&&GetIsObjectValid(AI_GetLauncherAmmo(oCreature));}
int AI_GetHighestActiveSpellLevel(object oTarget)
{
 int nHighest=0; effect e=GetFirstEffect(oTarget);
 while(GetIsEffectValid(e))
 {
  int nSpell=GetEffectSpellId(e);
  if(nSpell>=0){int nLevel=StringToInt(Get2DAString("spells","Innate",nSpell)); if(nLevel>nHighest)nHighest=nLevel;}
  e=GetNextEffect(oTarget);
 }
 return nHighest;
}
void AI_RemoveTaggedEffects(object oTarget,string sTag)
{
 effect e=GetFirstEffect(oTarget);
 while(GetIsEffectValid(e)){effect eNext=GetNextEffect(oTarget);if(GetEffectTag(e)==sTag)RemoveEffect(oTarget,e);e=eNext;}
}
void AI_EndTreeShape(object oPC)
{
 if(!GetIsObjectValid(oPC))return;
 object oTree=GetLocalObject(oPC,"AI_TREESHAPE_TREE");
 if(GetIsObjectValid(oTree))DestroyObject(oTree);
 AI_RemoveTaggedEffects(oPC,"AI_TREESHAPE");
 DeleteLocalObject(oPC,"AI_TREESHAPE_TREE"); DeleteLocalInt(oPC,"AI_TREESHAPE_ACTIVE");
 ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_POLYMORPH),oPC);
}
