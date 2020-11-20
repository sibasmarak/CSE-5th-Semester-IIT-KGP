#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "limits.h"

typedef struct edge{
    int y;                  // the end vertex of an edge (x,y) 
    int c;                  // capacity
    int f;                  // flow through that edge
    struct edge* next;      // next field to create a linklist of EDGE
} EDGE;

typedef struct vertex{
    int x;                  // id of the vertex
    int n;                  // storing the need of the vertex
    EDGE* p;                // pointer to the first node of the adjacency list of the vertex
} VERTEX;

typedef struct graph{
    int V;                  // number of vertices in graph
    int E;                  // number of edges in graph
    VERTEX** H;             // pointer to the array of vertex, each vertex holding its own adjacency list
} GRAPH;

typedef struct par{
    int data;               // stores the predecessors
    struct par* next;       // next field to create a linklist of par
} PARENT;

GRAPH* ReadGraph(char* fname);
void PrintGraph(GRAPH G);
void ComputeMaxFlow(GRAPH *G, int s, int t);
void NeedBasedFlow(GRAPH *G);
GRAPH* copyGraph(GRAPH* G);
GRAPH* createResidualGraph(GRAPH* G);
void updateTheGraph(GRAPH* residual, GRAPH* G);
void updateFlows(GRAPH* residual, PARENT* path, int resCap);
void findConstraintPath(GRAPH* residual, PARENT** path, PARENT** tempPath, PARENT** parent, int dest, int* resCap, int* flowPushed);
int doModifiedBFS(GRAPH* residual, PARENT** parent, int* dist, int source, int dest);

/* 
*** the ReadGraph(char* fname) function reads the graph from the file with file name as fnane
*** input: fname-> [char*] name of the file as string
*** output: g-> [GRAPH*] pointer to the adjacency list of graph formed
*/
GRAPH* ReadGraph(char* fname)
{
    GRAPH* g = (GRAPH*)malloc(sizeof(GRAPH));
    int N, M;       // N is the number of vertices and M is the number of edges
    
    FILE *fp = fopen(fname, "r");       // open the file fname
    fscanf(fp, "%d %d", &N, &M);        // read N and M from file fname

    g->V = N;
    g->E = M;
    g->H = (VERTEX**)malloc(N * sizeof(VERTEX*));
    
    int i, need;
    // initialize all the VERTEX* as NULL
    for(i = 0; i < N; i++)
        g->H[i] = NULL;      

    // read the second line of fname file
    // store the needs in respective vertices (0, 1, ..., N-1)
    // actually they are (1, 2, ..., N)
    for(i = 0; i < N; i++)
    {
        fscanf(fp, "%d", &need);        // read the need
        VERTEX* vertex = (VERTEX*)malloc(sizeof(VERTEX));
        vertex->x = i;
        vertex->n = need;
        vertex->p = NULL;
        g->H[i] = vertex;
    }

    // src: source; dest: destination; c: capacity
    int src, dest, c; 
    
    // read the remaining file content
    // there would be M lines corresponding to M edges
    // create the graph                
    for(i = 0; i < M; i++)
    {
        fscanf(fp, "%d%d%d", &src, &dest, &c);
        
        // create an edge with the given data
        EDGE* edge = (EDGE*)malloc(sizeof(EDGE));
        edge->y = (dest - 1);                       // subtract 1 to obtain the actual dest in the graph
        edge->next = g->H[src - 1]->p;
        edge->f = 0;
        edge->c = c;
        g->H[src - 1]->p = edge;
    }

    fclose(fp);             // close fp
    return g;               // return GRAPH* g
}   

/* 
*** the PrintGraph(GRAPH G) function prints the graph formed in the following format
*** 1 -> (y, c, f) -> (y, c, f) -> ...
*** 2 -> (y, c, f) -> (y, c, f) -> ...
*** ...
*** N -> (y, c, f) -> (y, c, f) -> ...

*** input: G-> [GRAPH] graph to be printed
*** output:  no return [void]
*/
void PrintGraph(GRAPH G)
{
    // obtain the number of vertices
    int N = G.V, i;
    VERTEX* vertex = NULL;
    EDGE* edge = NULL;

    // pick one vertex and print its adjacency list
    for(i = 0; i < N; i++)
    {
        vertex = G.H[i];                // select the vertex
        edge = vertex->p;               // obtain its first edge
        printf("%d", (vertex->x + 1));        // print the id
        while (edge != NULL)
        {
            printf(" -> (%d, %d, %d)", (edge->y + 1), edge->c, edge->f);
            edge = edge->next;
        }
        printf("\n");
    }
}

/*
*** This function creates the initial residual graph for input graph
*** input: G-> [GRAPH*] input graph
*** output: newGraph-> [GRAPH*] initial residual graph of G
*/
GRAPH* createResidualGraph(GRAPH* G)
{
    // copy the input graph G
    GRAPH* newGraph = (GRAPH*)malloc(sizeof(GRAPH));
    newGraph->V = G->V;
    newGraph->E = G->E;         
    newGraph->H = (VERTEX**)malloc((newGraph->V) * sizeof(VERTEX*));

    // copy vertex information from the G to newGraph
    int i;
    for(i = 0; i < newGraph->V; i++)
    {
        // copy the vertex information
        newGraph->H[i] = (VERTEX*)malloc(sizeof(VERTEX));
        newGraph->H[i]->p = NULL;
        newGraph->H[i]->n = G->H[i]->n;
        newGraph->H[i]->x = G->H[i]->x;
    }
    // copy the rest of the input graph
    // add the reverse edges, wherever aplicable 
    for(i = 0; i < G->V; i++)
    {
        // add the original edge
        // and also add the reverse edges
        // set both flow and capacity to be zero
        EDGE* new = NULL;
        EDGE* tempEdge = G->H[i]->p;
        while(tempEdge != NULL)
        {
            // add the src -> dest edge
            new = (EDGE*)malloc(sizeof(EDGE));
            new->next = NULL;
            new->c = tempEdge->c;
            new->f = tempEdge->c;
            new->y = tempEdge->y;
            if(newGraph->H[i]->p == NULL)
                newGraph->H[i]->p = new;
            else
            {
                EDGE* temp = newGraph->H[i]->p;
                while(temp->next != NULL)
                    temp = temp->next;
                temp->next = new;
            }
            
            // check if already dest -> src edge exists in input graph
            // if exists do not add the reverse edge
            int dest = new->y, exists = 0;
            EDGE* checker = G->H[dest]->p;
            while(checker != NULL && checker->y != i)
                checker = checker->next;

            if(checker != NULL)
                exists = 1;

            // add the dest -> src reverse edge
            if(!exists)
            {
                new = (EDGE*)malloc(sizeof(EDGE));
                new->next = NULL;
                new->c = 0;
                new->f = 0;
                new->y = i;
                if(newGraph->H[dest]->p == NULL)
                    newGraph->H[dest]->p = new;
                else
                {
                    EDGE* temp = newGraph->H[dest]->p;
                    while(temp->next != NULL)
                    {
                        temp = temp->next;
                    }  
                    temp->next = new;
                }
                
                // increment the number of edges
                newGraph->E++;
            }

            // move the edge pointer forward in the edge linkedlist of the vertex
            tempEdge = tempEdge->next;
        }
    }
    // return the initial residual graph
    return newGraph;
}

/*
*** this function uses the residual graph to update the flows in the original graph
*** input: residual-> [GRAPH*] residual graph
           G-> [GRAPH*] original graph to update the flow after maximum flow computation
*** output: no return [void]
*/
void updateTheGraph(GRAPH* residual, GRAPH* G)
{
    // update the flow assignment in the input graph G 
    // use the flow in residual
    EDGE* residualEdge = NULL;  // to access the edges of residual graph
    EDGE* GEdge = NULL;         // to access the edges of G graph
    EDGE* checker = NULL;       // to check if a particular edge of residual is there in G or not
    int i, vertices = G->V;

    for(i = 0; i < vertices; i++)
    {
        residualEdge = residual->H[i]->p;
        GEdge = G->H[i]->p;
        while(residualEdge != NULL)
        {
            checker = GEdge;
            while(checker != NULL)
            {
                // find a match of the 'y' values in G and residual 
                // ensures that the edge was originally there
                // not a reverse edge which was added later
                if(checker->y == residualEdge->y)
                {
                    // assign the flow from the residual Graph 
                    // only if the flow is less than the capacity
                    if(residualEdge->c > residualEdge->f)                   
                        checker->f = residualEdge->c - residualEdge->f;

                    break;
                }
                checker = checker->next;
            }
            residualEdge = residualEdge->next;
        }
    }

    // all the vetices have been scanned
    // the required original edges having flow greater than 0 have been updated in G
    return;
}

/*
*** this function updates the flows of residual graph, along the path found in accordance to given constraints;
*** input: residual-> [GRAPH*] residual graph whose flow along path to be updated;
           path-> [PARENT*] path found satisfying the given constraints;
           resCap-> [int] the exra flow that can move from source to sink;
*** output: no return [void] ;
*/
void updateFlows(GRAPH* residual, PARENT* path, int resCap)
{
    // along path[0] subtract resCap from each edge of residual
    // add the resCap in the reverse direction of each of the edges in path[0]
    int src, dest;

    // use search for edge in path; use searchRev for reverse edge in path
    EDGE* search, *searchRev; 
    
    // directly return for zero-length path
    if(path == NULL)
        return;
   
    // move along the path
    while(path->next != NULL)
    {
        src = path->data;
        dest = path->next->data;

        // in the edge src -> dest
        // subtract resCap
        search = residual->H[src]->p;
        while(search != NULL)
        {
            if(search->y == dest)
            {
                search->f -= resCap;
                break;
            }
            search = search->next;
        }

        // in the edge dest -> src
        // add resCap
        searchRev = residual->H[dest]->p;
        while(searchRev != NULL)
        {
            if(searchRev->y == src)
            {
                searchRev->f += resCap;
                break;
            }
            searchRev = searchRev->next;
        }

        // move p ahead in the path
        path = path->next;
    } 

    // flow has been updated for all the edges in the path
    return;
}

/*
*** this function finds the maximum residual capacity shortest path amongst all the shortest paths
*** input: residual-> [GRAPH*] residual graph
           path-> [PARENT*] the global path satisfying all the given constraints
           tempPath-> [PARENT*] the temporary path satisfying all the given constraints
           parent-> [PARENT**] parent array stores the parent of the vertices in a shortest path from source to sink
           dest-> [int] sink
           resCap-> [int] global residual capacity, corresponding to path
           flowPushed-> [int] temporary residual capacity, corresponding to tempPath
*** output: no return [void]
*/
void findConstraintPath(GRAPH* residual, PARENT** path, PARENT** tempPath, PARENT** parent, int dest, int *resCap, int *flowPushed)
{
    // parent contains the parent of a node in the shortest path from source to sink
    // parent[source] is -1, identifies that the start of a path
    // whenver a path starts, check if the current resCap is less than the residual along path
    // if so, then do update the path, and the resCap
    //tempPath stores at one instance a temorarary shortest path from src -> dest

    EDGE* search = NULL; 
    // Base Case 
    // if the parent of the current node pointed by tempPath is -1
    // we have reached the source
    // end the recursion
    if(parent[(*tempPath)->data]->data == -1) 
    {
        // check if this path has higher flowPushed than the current resCap
        if(flowPushed > resCap)
        {
            *path = *tempPath;        // update the global constraint path
            *resCap = *flowPushed;    // update the global flow to be pushed
        }
        return; 
    } 

    // Go through all the parents of the given vertex indicated by tempPath
    int d = (*tempPath)->data, s, shouldAdd = 0;
    PARENT* par = parent[d];
    while(par != NULL)
    { 
        // add an edge from s -> d in tempPath
        s = par->data;
        
        // update the flowPushed
        // if shouldAdd is true, then only add the edge into the tempPath
        search = residual->H[s]->p;
        while(search != NULL)
        {
            if(search->y == d && search->f > 0)
            {
                shouldAdd = 1;
                *flowPushed = (search->f < *flowPushed) ? search->f : *flowPushed;
                break;
            }
            search = search->next;
        } 
        if(shouldAdd)
        {
            // add an edge from s -> d in tempPath
            PARENT* new = (PARENT*)malloc(sizeof(PARENT));
            new->data = s;
            new->next = *tempPath;
            *tempPath = new;

            // Recursive call for its parent 
            findConstraintPath(residual, path, tempPath, parent, dest, resCap, flowPushed); 
    
            // Remove the current vertex 
            *tempPath = (*tempPath)->next;
        }

        // move to the next parent of the current vertex
        par = par->next;
    }
    return;
}

/*
*** this function creates the parent array for the shortes path from source to dest
*** input: residual-> [GRAPH*] residual graph
           parent-> [PARENT**] parent array - stores the parent of all the nodes along the shortest path
           dist-> [int*] distance array from source
           source-> [int] source
           dest-> [int] destination array
*** output: [bool] true, if a path exists from source to dest; else false
*/
int doModifiedBFS(GRAPH* residual, PARENT** parent, int* dist, int source, int dest)
{
    // define a queue for the BFS 
    // add the source to the queue
    PARENT* queue = NULL, *last = NULL, *popped = NULL, *new = NULL, *par = NULL;
    int poppedVertex, adjacent;
    EDGE* scan = NULL;

    queue = (PARENT*)malloc(sizeof(PARENT));
    queue->data = source;
    queue->next = NULL;
    last = queue;

    while(queue != NULL)
    {
        // pop the first element
        popped = queue;
        queue = queue->next;

        // find the poppedVertex in the residual graph
        poppedVertex = popped->data;
        scan = residual->H[poppedVertex]->p;

        // add the adjacency vertex of the poppedVertex to the queue
        // update the parent array for the adjacent of poppedVertex
        while(scan != NULL)
        {
            adjacent = scan->y;

            // we found a shorter path
            // remove the current parent list
            // add poppedVertex into the parent of scan->y
            // update the dist array
            if(dist[adjacent] > dist[poppedVertex] + 1)
            {
                
                // if there is a flow possible through that edge
                // then only add the poppedVertex to the parent
                if(scan->f > 0)
                {
                    par = (PARENT*)malloc(sizeof(PARENT));
                    par->data = poppedVertex;
                    par->next = NULL;
                    parent[adjacent] = par;
                    dist[adjacent] = dist[poppedVertex] + 1;
                }

                // add the adjacent into the queue
                // if queue is NULL, allocate memory and assign last and queue to the same memory
                if(queue == NULL)
                {
                    queue = (PARENT*)malloc(sizeof(PARENT));
                    queue->data = adjacent;
                    queue->next = NULL;
                    last = queue;
                }
                // if queue is not NULL
                // last is not empty and contains the last node
                // create a new node and extend the linkedList from last
                else
                {
                    new = (PARENT*)malloc(sizeof(PARENT));
                    new->data = adjacent;
                    new->next = NULL;
                    last->next = new;
                    last = last->next;
                }
            }
            // we found another parent which connects via an edge with flow > 0
            // it is also of same dist
            // so simply add poppedVertex to the parent of adjacent 
            else if(scan->f > 0 && dist[adjacent] == dist[poppedVertex] + 1)
            {
                par = (PARENT*)malloc(sizeof(PARENT));
                par->data = poppedVertex;
                par->next = parent[adjacent];
                parent[adjacent] = par;
            }

            // move to the next adjacenct vertex
            scan = scan->next;
        }
    }
    // if the parent of dest is not NULL
    // return True
    if(parent[dest] != NULL)
        return 1;
    return 0;
}

/*
*** Finds and prints the maximum flow of the input graph. Updates the flow assignment of input graph.
*** input: G-> [GRAPH*] input graph to find the maximum flow
           s-> [int] source
           t-> [int] sink
*** output: no return [void] 
*/
void ComputeMaxFlow(GRAPH *G, int s, int t)
{
    // design the residual Graph
    // do all the surgery on residual graph 
    // with the last residual graph, evaluate the flow values and update G before printing max-flow
    // creates the initial residual graph of G
    GRAPH* residual = createResidualGraph(G);

    int i, vertices = G->V;
    PARENT** parent = (PARENT**)malloc(vertices * sizeof(PARENT*));
    for(i = 0; i < vertices; i++)
        parent[i] = NULL;

    // initial maxFlow is 0
    int maxFlow = 0;

    // set the parent of source to be -1
    // this ensures while checking all the shortest augmenting paths
    // we end the recursion at the parent
    parent[s-1] = (PARENT*)malloc(sizeof(PARENT));
    parent[s-1]->data = -1;
    parent[s-1]->next = NULL;

    // define the dist array
    // stores the distance from source to all reachable vertices
    int* dist = (int*)malloc(vertices * sizeof(int));
    for(i = 0; i < vertices; i++)
        dist[i] = 200000;
    dist[s-1] = 0;

    // begin a while loop
    // The while condition populates the parent array with the aid of BFS
    // maintain the shortest distance from the source = s - 1
    // returns true if parent[t-1] is not NULL
    int isPath = doModifiedBFS(residual, parent, dist, s-1, t-1);
    while(isPath)
    {

        // define the path array
        // it always stores the path which satisfies the constraint among all paths seen
        PARENT* path = (PARENT*)malloc(sizeof(PARENT));
        path->data = t-1;
        path->next = NULL;

        // define the tempPath array
        PARENT* tempPath = (PARENT*)malloc(sizeof(PARENT));
        tempPath->data = t-1;
        tempPath->next = NULL;

        // traverses all the paths with the aid of parent array
        // finds the residual capacity of each path
        // path/tempPath pointer moves back, as we access a new parent - hence the path at the end contains a (s -> t) path
        // update the path and corresponding resCap as we encounter higher residual capacitites
        int resCap = INT_MIN, flowPushed = INT_MAX;
        findConstraintPath(residual, &path, &tempPath, parent, t-1, &resCap, &flowPushed);

        // updates the flow assignment of edges in path (s -> t) of residual graph
        // add resCap in the opposite direction
        // subtract resCap in the same direction
        updateFlows(residual, path, resCap);

        // update the maxFlow value
        maxFlow += resCap;

        // set the parent of source to be -1
        // this ensures while checking all the shortest augmenting paths
        // we end the recursion at the parent
        for(i = 0; i < vertices; i++)
            parent[i] = NULL;
        parent[s-1] = (PARENT*)malloc(sizeof(PARENT));
        parent[s-1]->data = -1;
        parent[s-1]->next = NULL;

        // define the dist array
        // stores the distance from source to all reachable vertices
        for(i = 0; i < vertices; i++)
            dist[i] = 200000;
        dist[s-1] = 0;

        // check if there is a path
        isPath = doModifiedBFS(residual, parent, dist, s-1, t-1);
        
    }
    printf("\nThe maximum flow of given graph = %d\n(P.S. Ignore the above value when calling needBasedFlow function)\n", maxFlow);

    // with the aid of residual graph
    // update the flow assignment of input graph G
    updateTheGraph(residual, G);
    return;
}

/*
*** This function copies the input graph and adds two more vertices - superSource and superSink (but not the relevant edges)
*** input: G-> [GRAPH*] input graph
*** output: newGraph-> [GRAPH*] new graph with the superSource and superSink
*/
GRAPH* copyGraph(GRAPH* G)
{
    // copy the input graph G
    // add two extra vertices - superSource (G->V) and superSink (G->V + 1)
    // edges will be incremented while identifying consumers and producers in needBasedFlow
    GRAPH* newGraph = (GRAPH*)malloc(sizeof(GRAPH));
    newGraph->V = G->V + 2;
    newGraph->E = G->E;         
    newGraph->H = (VERTEX**)malloc((newGraph->V) * sizeof(VERTEX*));

    // create the superSink
    VERTEX* superSink = (VERTEX*)malloc(sizeof(VERTEX));
    superSink->n = 0;
    superSink->p = NULL;
    superSink->x = newGraph->V - 1;
    newGraph->H[newGraph->V - 1] = superSink;

    // create the superSource
    VERTEX* superSource = (VERTEX*)malloc(sizeof(VERTEX));
    superSource->n = 0;
    superSource->p = NULL;
    superSource->x = newGraph->V - 2;
    newGraph->H[newGraph->V - 2] = superSource; 
    
    // copy the rest of the input graph
    int i;
    for(i = 0; i < G->V; i++)
    {
        // copy the vertex information
        // changing the flow in the newGraph would be able to modify the flow in input graph
        // since they both point to the same array
        // we do not need to copyFlow from newGraph to input graph after calling computeMaxFlow on newGraph
        newGraph->H[i] = (VERTEX*)malloc(sizeof(VERTEX));
        newGraph->H[i]->p = G->H[i]->p;
        newGraph->H[i]->n = G->H[i]->n;
        newGraph->H[i]->x = G->H[i]->x;
    }

    // return the new graph with the superSink and superSource
    return newGraph;
}

/*
*** This function evaluates if need based flow is possible for the input graph or not. 
*** If need based flow is possible, then prints the maximum need based flow and updates the flow assignment of input graph.
*** input: G -> [GRAPH*] input graph to find need based flow
*** output: no return [void]
*/
void NeedBasedFlow(GRAPH *G)
{
    int i, vertices = G->V, need; 
    int production = 0, consumption = 0;
    int consumerCount = 0, producerCount = 0;

    // copy the input graph
    // create the superSource and superSink vertices
    // the number of vertices in newGraph is 2 more than input graph G
    // from vertex 0 to (G->V - 1) both the graph are same
    // newGraph[newGraph->V - 2] is superSource
    // newGraph[newGraph->V - 1] is superSink
    GRAPH* newGraph = copyGraph(G);

    // create consumer array
    // vertices whose need > 0
    // consumer[i] implies i is a consumer
    int* consumer = (int*)malloc(vertices * sizeof(int));
    memset(consumer, 0, vertices * sizeof(int));

    // create producer array
    // vertices whose need < 0
    // producer[i] implies i is a producer
    int* producer = (int*)malloc(vertices * sizeof(int));
    memset(producer, 0, vertices * sizeof(int));

    // calculate the production and consumption
    // count the number of producers and consumers
    // populate the consumer and producer array
    // join the superSource with producers and consumers with superSink
    for(i = 0; i < vertices; i++)
    {
        need = G->H[i]->n;
        if( need > 0 )
        {
            // the vertex i is a consumer
            consumer[i] = 1;
            consumption += need;
            consumerCount++;
            
            // add the superSink vertex to vertex i
            EDGE* tempEdge = newGraph->H[i]->p;
            EDGE* toSuperSink = NULL;
            if(tempEdge == NULL)
            {
                toSuperSink = (EDGE*)malloc(sizeof(EDGE));
                toSuperSink->next = NULL;
                toSuperSink->y = (newGraph->V - 1);
                toSuperSink->f = 0;
                toSuperSink->c = need;
                newGraph->H[i]->p = toSuperSink;
                newGraph->E++;
            } 
            else
            {
                while(tempEdge->next != NULL)
                    tempEdge = tempEdge->next;
                EDGE* toSuperSink = (EDGE*)malloc(sizeof(EDGE));
                toSuperSink->next = NULL;
                toSuperSink->y = (newGraph->V - 1);
                toSuperSink->f = 0;
                toSuperSink->c = need;
                tempEdge->next = toSuperSink;
                newGraph->E++;
            }
        }
        else if( need < 0 )
        {
            // the vertex i is a producer
            producer[i] = 1;
            production -= need;
            producerCount++;

            // add the vertex i to the superSource vertex
            EDGE* temp = newGraph->H[newGraph->V - 2]->p;
            if(temp == NULL)
            {
                EDGE* fromSuperSource = (EDGE*)malloc(sizeof(EDGE));
                fromSuperSource->next = NULL;
                fromSuperSource->y = i;
                fromSuperSource->c = (-1)*need;
                fromSuperSource->f = 0;
                newGraph->H[G->V]->p = fromSuperSource;
                newGraph->E++;
            }
            else
            {
                while(temp->next != NULL)
                    temp = temp->next;
                EDGE* fromSuperSource = (EDGE*)malloc(sizeof(EDGE));
                fromSuperSource->next = NULL;
                fromSuperSource->y = i;
                fromSuperSource->c = (-1)*need;
                fromSuperSource->f = 0;
                temp->next = fromSuperSource;
                newGraph->E++;
            }
        }
    }

    // check trivial conditions
    // if all are consumer or producer
    // return need based flow not possible
    if(consumerCount == vertices || producerCount == vertices || production != consumption)
    {
        printf("Very sorry to say, Need Based Flow not possible!\n");
        return;
    }

    // compute the Max Flow
    ComputeMaxFlow(newGraph, newGraph->V - 1, newGraph->V);       

    // check if all the edges in superSource are saturated
    // if one of the edge is not saturated
    // then return need based flow not possible
    // else the need based flow is the production
    EDGE* checker = newGraph->H[newGraph->V - 2]->p;
    while(checker != NULL && (checker->f == checker->c))
        checker = checker->next;
    
    if(checker != NULL)
    {
        printf("Very sorry to say, Need Based Flow not possible!\n");

        // remove the edges from vertices to superSink before returning
        for(i = 0; i < vertices; i++)
        {
            // if the vertex is consumer
            // remove the edge of given consumer to superSink
            if(consumer[i] == 1)
            {
                EDGE* prev = G->H[i]->p;
                checker = prev->next;
                
                // run a loop till checker is non NULL and checker->y is not superSink
                while(checker != NULL)
                {
                    if(checker->y == newGraph->V - 1)
                    {
                        prev->next = checker->next;
                        break;
                    }
                    prev = checker;
                    checker = prev->next;
                }
            }
        }
        return;
    }

    // print the need based Flow
    printf("Yay! we got Need Based Flow = %d\n", production);

    // remove the edges from vertices to superSink before returning
    for(i = 0; i < vertices; i++)
    {
        // if the vertex is consumer
        // remove the edge of given consumer to superSink
        if(consumer[i] == 1)
        {
            EDGE* prev = G->H[i]->p;
            if(prev != NULL)
            {
                checker = prev->next;
                
                // run a loop till checker is non NULL and checker->y is not superSink
                while(checker != NULL)
                {
                    if(checker->y == newGraph->V - 1)
                    {
                        prev->next = checker->next;
                        break;
                    }
                    prev = checker;
                    checker = prev->next;
                }
            }
            
        }
    }

    return;
}

int main()
{
    printf("\n---------- Welcome to First Programming Assignment on Flow ----------\n");
    printf("++ Name: Siba Smarak Panigrahi\n");
    printf("++ Roll No.: 18CS10069\n");
    printf("---------- Introduction Over ----------\n");

    printf("\n#################### Keep the input text file ready! ####################\n");
    char* fname = (char*)malloc(22*sizeof(char));
    printf("Enter the file name: \n");
    scanf("%[^\n]s", fname);
    GRAPH* graph = ReadGraph(fname);
    PrintGraph(*graph);

    printf("\n#################### ComputeMaxFlow ####################\n");
    int source, sink;
    printf("\nEnter Source: ");
    scanf("%d", &source);
    printf("Enter Sink: ");
    scanf("%d", &sink);
    ComputeMaxFlow(graph, source, sink);
    PrintGraph(*graph);

    printf("\n#################### NeedBasedFlow ####################\n");
    graph = ReadGraph(fname);
    NeedBasedFlow(graph);
    PrintGraph(*graph);

    printf("\n--------------------------------------------------\n++ Thank You! Hope You Enjoyed! Stay Safe! ++\n--------------------------------------------------\n");
    return 0;
}
