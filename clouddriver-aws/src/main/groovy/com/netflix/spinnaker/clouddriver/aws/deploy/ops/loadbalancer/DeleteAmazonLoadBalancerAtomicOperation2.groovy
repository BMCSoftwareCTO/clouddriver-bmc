package com.netflix.spinnaker.clouddriver.aws.deploy.ops.loadbalancer

import com.amazonaws.services.elasticloadbalancing.model.DeleteLoadBalancerRequest
import com.netflix.spinnaker.clouddriver.aws.deploy.description.DeleteAmazonLoadBalancerDescription
import com.netflix.spinnaker.clouddriver.aws.security.AmazonClientProvider
import com.netflix.spinnaker.clouddriver.data.task.Task
import com.netflix.spinnaker.clouddriver.data.task.TaskRepository
import com.netflix.spinnaker.clouddriver.orchestration.AtomicOperation
import org.springframework.beans.factory.annotation.Autowired

/**
 * Created by osboxes on 24/03/16.
 */
class DeleteAmazonLoadBalancerAtomicOperation2 implements AtomicOperation<Void> {

    private static final String BASE_PHASE = "DELETE_ELB"

    private static Task getTask() {
        TaskRepository.threadLocalTask.get()
    }

    @Autowired
    AmazonClientProvider amazonClientProvider

    private final DeleteAmazonLoadBalancerDescription description

    DeleteAmazonLoadBalancerAtomicOperation2(DeleteAmazonLoadBalancerDescription description) {
        this.description = description
    }

    @Override
    Void operate(List priorOutputs) {
        task.updateStatus BASE_PHASE, "Initializing Delete Amazon Load Balancer Operation..."
        for (region in description.regions) {
            def loadBalancing = amazonClientProvider.getAmazonElasticLoadBalancing(description.credentials, region, true)
            DeleteLoadBalancerRequest request = new DeleteLoadBalancerRequest(loadBalancerName: description.loadBalancerName)
            task.updateStatus BASE_PHASE, "Deleting ${description.loadBalancerName} in ${region} for ${description.credentials.name}."
            loadBalancing.deleteLoadBalancer(request)
        }
        task.updateStatus BASE_PHASE, "Done deleting ${description.loadBalancerName} in ${description.regions} for ${description.credentials.name}."
        null
    }

}
