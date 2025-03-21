# Load necessary libraries
library(limma)
library(org.Hs.eg.db)
library(AnnotationDbi)

# Get KEGG gene links for human species
gene_kegg_links <- getGeneKEGGLinks(species = "hsa")

# Map Gene IDs to Gene Symbols
gene_kegg_links$Symbol <- mapIds(org.Hs.eg.db,
                                 keys = gene_kegg_links$GeneID,
                                 column = "SYMBOL",
                                 keytype = "ENTREZID",
                                 multiVals = "first")

# Get KEGG pathway names for human species
pathway_names <- getKEGGPathwayNames(species = "hsa")

# Merge the two data frames based on the KEGG Pathway ID
# gene_kegg_links has 'PathwayID', pathway_names has 'PathwayID'
merged_df <- merge(gene_kegg_links, pathway_names, by = "PathwayID")

# Display the first few rows of the merged dataframe
head(merged_df)

# Save the merged dataframe to a CSV file
write.csv(merged_df, file = "Human_KEGG_Pathways_Genes.csv", row.names = FALSE)
