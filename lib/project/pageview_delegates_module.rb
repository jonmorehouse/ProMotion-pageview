module ProMotion
  module PageViewDelegatesModule
    
    def pageViewController(pageview, viewControllerBeforeViewController:screen)
      previous_screen(screen)
    end

    def pageViewController(pageview, viewControllerAfterViewController:screen)
      next_screen(screen)
    end

    def presentationCountForPageViewController(pageview)
      return presentation_screen_count if respond_to?(:presentation_screen_count)
      0
    end

    def presentationIndexForPageViewController(pageview)
      return presentation_screen_index if respond_to?(:presentation_screen_index)
      0
    end

    def pageViewController(pageview, willTransitionToViewControllers:screens)
      will_transition(screens) if respond_to?(:will_transition) 
    end

    def pageViewController(pageview, didFinishAnimating:finished_animating, previousViewControllers:previous, transitionCompleted: transition_completed)
      did_transition(screen) if respond_to?(:did_transition)
    end

    def pageViewController(pageview, spineLocationForInterfaceOrientation:spine)
      # NOTE no use for this now
      spine_location(spine) if respond_to?(:spine_location)
    end
  end
end
